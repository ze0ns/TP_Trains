//
//  StationsModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import Foundation
struct StationsModel: Identifiable, Codable {
    var id = UUID()
    let title: String
    let code: String
    let longitude, latitude: Double
}
struct NearestStationsResponse: Codable {
    let stations: [APIStation]
}

struct APIStation: Codable {
    let title: String?
    let codes: APICodes?
    let lat: Double?
    let lng: Double?
}

struct APICodes: Codable {
    let yandex_code: String?
    // если есть esr_code, добавьте сюда
}
