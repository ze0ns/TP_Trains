//
//  TransporterViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine
import OpenAPIURLSession

@MainActor
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
                    await MainActor.run {
                        self.trains = []
                    }
                    return
                }
                // 2. Мапим именно массив
                let mappedTransporter = transporterArray.map { apiTransporter in
                    TrainScheduleModel(operatorName: apiTransporter.thread?.carrier?.title ?? "",
                                       iconName: apiTransporter.thread?.carrier?.logo ?? "rzd",
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
                }
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}
extension TransporterViewModel{
    func fetshCarrierInfoService(carrierCode: String) {
        Task {
            do {
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CarrierInfoService(
                    client: client,
                    apikey: self.yaApiKey
                )
                print("Fetching carrierInfo...")
                let carrierInfo = try await service.getCarrierInfo(code: carrierCode, system: "yandex", lang: "ru_RU")
                print("Successfully fetched carrierInfo: \(carrierInfo)")
            } catch {
                print("Error fetching carrierInfo: \(error)")
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
