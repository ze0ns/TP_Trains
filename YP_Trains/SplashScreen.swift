//
//  SplashScreen.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI
import OpenAPIURLSession
struct SplashScreen: View {
    @State private var isActive = true
    
    var body: some View {
        if isActive {
            Color.black
                .ignoresSafeArea()
                .overlay {
                    Image(.splashScreen)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isActive = false
                    }
                    Task {
                        await loadInitialData()
                    }
                }
            
        } else {
            TrainsTabView()
        }
    }
    private func loadInitialData() async {
        let yaApiKey = Config.shared.getApiKey()

        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            let allCity = AllStationsService(client: client, apikey: yaApiKey)
            try await allCity.getAllStations()
            print("Данные успешно загружены в кэш")
        } catch {
            print("Ошибка при загрузке данных: \(error)")
        }
    }
}

#Preview {
    SplashScreen()
}
