//
//  StationsModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import Foundation
struct StationsModel: Identifiable {
    let id = UUID()
    let title: String
    let code: String
    let longitude, latitude: Double
}
