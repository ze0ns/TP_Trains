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
        
        loadMockData()
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
    
    func fetchSearchBetween() {
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
                    date: "2026-04-30"
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
                                       transportDate: self.secondsToDurations.extractDateString(from: apiTransporter.arrival?.ISO8601Format() ?? "") ?? "",
                                       departureTime: self.secondsToDurations.extractTimeOnly(from: apiTransporter.departure?.ISO8601Format() ?? "") ?? "" ,
                                       arrivalTime: self.secondsToDurations.extractTimeOnly(from: apiTransporter.arrival?.ISO8601Format() ?? "") ?? "",
                                       duration: self.secondsToDurations.formatTime(seconds: apiTransporter.duration ?? 0))
                }
                print("Successfully fetched stations: \(mappedTransporter)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}
