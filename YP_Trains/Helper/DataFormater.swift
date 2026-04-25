//
//  DataFormater.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Custom Date Decoding Strategy
extension JSONDecoder {
    static func yandexRaspDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        
        // Настройка форматтера для дат
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Пробуем разные форматы дат от Яндекс.Расписаний
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            // Форматы дат, которые может вернуть API
            let formats = [
                "yyyy-MM-dd'T'HH:mm:ssZ",     // 2024-12-25T14:30:00+0300
                "yyyy-MM-dd'T'HH:mm:ss.SSSZ",  // 2024-12-25T14:30:00.123+0300
                "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ", // с микросекундами
                "yyyy-MM-dd HH:mm:ss",         // 2024-12-25 14:30:00
                "yyyy-MM-dd"                    // 2024-12-25
            ]
            
            for format in formats {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.dateFormat = format
                
                if let date = formatter.date(from: dateString) {
                    return date
                }
            }
            
            // Если ничего не подошло, пробуем ISO8601 с опциями
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = isoFormatter.date(from: dateString) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot parse date: \(dateString)"
            )
        }
        
        return decoder
    }
}
