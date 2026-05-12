//
//  ExtesionColor.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 12.05.2026.
//

import Foundation
import SwiftUI

extension Color {
    // Адаптивный фон для карточек и полей ввода
    static var ypCardBackground: Color {
        Color(UIColor.secondarySystemGroupedBackground)
    }
    
    // Адаптивный основной фон экрана
    static var ypMainBackground: Color {
        Color(UIColor.systemGroupedBackground)
    }
    
    // Если ypBlue задан статично в Assets, он может резать глаз в темной теме.
    // Делаем его чуть темнее в темной теме (замените hex на свой, если нужно):
    static var adaptiveYpBlue: Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
            ? UIColor(red: 0.15, green: 0.35, blue: 0.65, alpha: 1.0) // Темно-синий
            : UIColor(red: 0.22, green: 0.45, blue: 0.90, alpha: 1.0) // Стандартный синий
        })
    }
}
