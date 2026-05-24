//
//  TransporterViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine
import OpenAPIURLSession

// MARK: - ViewModel
final class TransporterViewModel: ObservableObject {
    let routeTrains: String
    let fromStations: String
    let toStations: String
    let yaApiKey = Config.shared.getApiKey()
    let secondsToDurations = SecondsToDurations()

    
    @Published var trains: [TrainScheduleModel] = []
    @Published var showFilter: Bool = false
    
    let routeFilterViewModel = RouteFilterViewModel()
    
    init(routeTrains: String, fromStations: String, toStations: String) {
        self.routeTrains = routeTrains
        self.fromStations = fromStations
        self.toStations = toStations
        self.fetchSearchBetween()
        //loadMockData()
    }
    
    private func loadMockData() {
        self.trains = [
            TrainScheduleModel(operatorName: "РЖД", iconName: "rzd", carrierCode: 112, transferName: "С пересадкой в Костроме", transportDate: "15 февраля", departureTime: "22:30", arrivalTime: "08:15", duration: "9 ч 45 мин"),
            TrainScheduleModel(operatorName: "ФГК", iconName: "ural", carrierCode: 112, transferName: "С пересадкой в Москве", transportDate: "16 февраля", departureTime: "23:00", arrivalTime: "08:15", duration: "9 ч 15 мин"),
            TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", carrierCode: 112, transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин"),
            TrainScheduleModel(operatorName: "РЖД", iconName: "ural", carrierCode: 112, transferName: nil, transportDate: "18 февраля", departureTime: "00:10", arrivalTime: "08:40", duration: "8 ч 30 мин"),
            TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", carrierCode: 112, transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин")
        ]
        print("++++++++++++++++++++++++++++++++")
        print(fromStations)
        print(toStations)
        print("++++++++++++++++++++++++++++++++")
    }
    
    func openFilter() {
        showFilter = true
    }
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    func fetchSearchBetween() {
        let currentDate = Date()
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = SearchBetweenStationsService(
                    client: client,
                    apikey: yaApiKey
                )
                
                print("Fetching shedule...")
                let schedule = try await service.getScheduleBetweenStations(
                    from: fromStations ,
                    to: toStations,
                    date: "2026-06-30"
                )
                
                guard let transporterArray = schedule.segments else {
                    // Если данных нет, очищаем список на экране
                    await MainActor.run {
                        self.trains = []
                   //     self.isLoading = false // Выключаем индикатор загрузки
                    }
                    return
                }
                // 2. Мапим именно массив
                let mappedTransporter = transporterArray.map { apiTransporter in
                    TrainScheduleModel(operatorName: apiTransporter.thread?.carrier?.title ?? "",
                                       iconName: "rzd",
                                       carrierCode: apiTransporter.thread?.carrier?.code ?? 0,
                                       transferName: "",
                                       transportDate: self.extractDateString(from: apiTransporter.arrival ?? currentDate),
                                       departureTime: self.extractTimeOnly(from: apiTransporter.departure ?? currentDate) ?? "",
                                       arrivalTime: self.extractTimeOnly(from: apiTransporter.arrival ?? currentDate) ?? "",
                                       duration: self.formatTime(seconds: apiTransporter.duration ?? 0))
                }
                print("Successfully fetched stations: \(mappedTransporter)")
                
                // 3. Обновляем UI
                await MainActor.run {
                    self.trains = mappedTransporter
                    //self.isLoading = false // Выключаем индикатор загрузки
                }
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}
extension TransporterViewModel{
    func extractDateString(from date: Date) -> String {
        return Self.dateFormatter.string(from: date)
    }
    func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        func pluralize(_ number: Int, forms: [String]) -> String {
            let lastDigit = number % 10
            let lastTwoDigits = number % 100
            
            if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
                return forms[2]
            } else if lastDigit == 1 {
                return forms[0]
            } else if lastDigit >= 2 && lastDigit <= 4 {
                return forms[1]
            } else {
                return forms[2]
            }
        }
        
        let hourString = pluralize(hours, forms: ["час", "часа", "часов"])
        let minuteString = pluralize(minutes, forms: ["минуту", "минуты", "минут"])
        
        if hours > 0 {
            return "\(hours) \(hourString) \(minutes) \(minuteString)"
        } else if minutes > 0 {
            return "\(minutes) \(minuteString)"
        } else {
            return "0 минут"
        }
    }
    func extractTimeOnly(from date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }
}
