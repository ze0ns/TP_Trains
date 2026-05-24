//
//  SecondsToDurations.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 24.05.2026.
//

import Foundation
struct SecondsToDurations {
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
    func extractDateString(from dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withTimeZone]
        
        guard let date = formatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        return outputFormatter.string(from: date)
    }
    func extractTimeOnly(from dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withTimeZone]
        
        guard let date = formatter.date(from: dateString) else {
            return nil
        }
        
        // Используем форматтер для извлечения времени
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return timeFormatter.string(from: date)
    }
}
