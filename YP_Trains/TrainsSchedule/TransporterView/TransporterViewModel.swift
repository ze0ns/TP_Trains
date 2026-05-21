//
//  TransporterViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine

// MARK: - ViewModel
final class TransporterViewModel: ObservableObject {
    let routeTrains: String
    @Published var trains: [TrainScheduleModel] = []
    @Published var showFilter: Bool = false
    
    let routeFilterViewModel = RouteFilterViewModel()
    
    init(routeTrains: String) {
        self.routeTrains = routeTrains
        loadMockData()
    }
    
    private func loadMockData() {
        self.trains = [
            TrainScheduleModel(operatorName: "РЖД", iconName: "rzd", transferName: "С пересадкой в Костроме", transportDate: "15 февраля", departureTime: "22:30", arrivalTime: "08:15", duration: "9 ч 45 мин"),
            TrainScheduleModel(operatorName: "ФГК", iconName: "ural", transferName: "С пересадкой в Москве", transportDate: "16 февраля", departureTime: "23:00", arrivalTime: "08:15", duration: "9 ч 15 мин"),
            TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин"),
            TrainScheduleModel(operatorName: "РЖД", iconName: "ural", transferName: nil, transportDate: "18 февраля", departureTime: "00:10", arrivalTime: "08:40", duration: "8 ч 30 мин"),
            TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин")
        ]
    }
    
    func openFilter() {
        showFilter = true
    }
}
