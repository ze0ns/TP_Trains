//
//  City.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import Foundation

struct CityModel: Identifiable, Codable {
    let id = UUID()
    let title: String
    let latitude: String
    let longitude: String
    let yandexCode: String?
    
    // Для создания вручную (если понадобится)
    init(title: String, latitude: String, longitude: String, yandexCode: String? = nil) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.yandexCode = yandexCode
    }
    
    // Для создания из модели Settlement, которую отдает API
    init(from settlement: Settlement) {
        self.title = settlement.title
        self.yandexCode = settlement.codes.yandexCode
        
        // Достаем координаты из первой станции в этом населенном пункте,
        // так как у самого Settlement координат в схеме API нет
        if let firstStation = settlement.stations.first {
            self.latitude = CityModel.itudeToString(firstStation.latitude)
            self.longitude = CityModel.itudeToString(firstStation.longitude)
        } else {
            // Если станций нет, ставим заглушку
            self.latitude = "0.0"
            self.longitude = "0.0"
        }
    }
    
    // Вспомогательный метод для конвертации enum Itude в String
    private static func itudeToString(_ itude: Itude?) -> String {
        guard let itude = itude else { return "0.0" }
        switch itude {
        case .double(let value):
            return String(value)
        case .string(let value):
            return value
        }
    }
}
