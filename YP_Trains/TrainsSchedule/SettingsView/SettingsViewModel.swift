//
//  SettingsViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 17.05.2026.
//

import SwiftUI
import Combine

@Observable class SettingsViewModel {
    var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            print("Тема изменена на: \(isDarkMode ? "темную" : "светлую")")
        }
    }
    
    let urlString = "https://yandex.ru/legal/practicum_offer"
    let appVersion = "1.0 (beta)"
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    var userAgreementURL: URL? {
        guard !urlString.isEmpty else { return nil }
        return URL(string: urlString)
    }
    
    var userAgreementTitle: String {
        "Пользовательское соглашение"
    }
}
