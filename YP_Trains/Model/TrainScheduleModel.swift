//
//  TrainScheduleModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 08.05.2026.
//

import Foundation
// MARK: - Модель данных
struct TrainScheduleModel: Identifiable {
    let id = UUID()
    let operatorName: String
    let iconName: String
    let transferName: String?
    let transportDate: String
    let departureTime: String
    let arrivalTime: String
    let duration: String
}
