//
//  ExtesionColor.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 12.05.2026.
//

import SwiftUI

extension Color {
    static let backgroundColor: Color = Color(UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
                .ypWhiteNight
        default:
                .ypWhiteDay
        }
    })
    
    static let mainTextColor: Color = Color(UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
                .ypBlackNight
        default:
                .ypBlackDay
        }
    })
    static let tabLineColor: Color = Color(UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
                .ypBlackDay
        default:
                .ypLiteGray
        }
    })
    static let textCitySearchColor: Color = Color(UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
                .ypBlackDay
        default:
                .ypLiteGray
        }
    })
    static let textCityColor: Color = Color(UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .dark:
                .ypBlackNight
        default:
                .ypBlackDay
        }
    })
    
    static var ypCardBackground: Color {
        .ypWhiteDay
    }
    
}
