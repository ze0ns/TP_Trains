//
//  YP_TrainsApp.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import SwiftUI

@main
struct YP_TrainsApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
