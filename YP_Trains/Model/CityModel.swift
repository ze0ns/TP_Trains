//
//  City.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import Foundation

struct CityModel: Identifiable {
    let id = UUID()
    let title: String
    let lat: String
    let lng: String
    let yandexCode: String? // Оставляем, он нужен для поиска
    
    // Для создания вручную (если понадобится)
    init(title: String, lat: String, lng: String, yandexCode: String? = nil) {
        self.title = title
        self.lat = lat
        self.lng = lng
        self.yandexCode = yandexCode
    }
    
    // Для создания из модели Settlement, которую отдает API
    init(from settlement: Settlement) {
        self.title = settlement.title
        self.yandexCode = settlement.codes.yandexCode
        
        // Достаем координаты из первой станции в этом населенном пункте,
        // так как у самого Settlement координат в схеме API нет
        if let firstStation = settlement.stations.first {
            self.lat = CityModel.itudeToString(firstStation.latitude)
            self.lng = CityModel.itudeToString(firstStation.longitude)
        } else {
            // Если станций нет, ставим заглушку
            self.lat = "0.0"
            self.lng = "0.0"
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
