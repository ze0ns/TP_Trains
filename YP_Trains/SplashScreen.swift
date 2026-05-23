//
//  SplashScreen.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

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
                    fetchAllStations()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isActive = false
                    }
                }
        } else {
            TrainsTabView()
        }
    }
}
func fetchAllStations() {
    let yaApiKey = Config.shared.getApiKey()
    Task {
        do {
            // 1. Формируем URL для прямого запроса
            let urlString = "https://api.rasp.yandex.net/v3.0/stations_list/?apikey=\(yaApiKey)&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Ошибка: неверный URL")
                return
            }
            
            print("Fetching allStations via URLSession...")
            
            // 2. Делаем стандартный сетевой запрос
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Ошибка: сервер вернул не 200")
                return
            }
            
            // 3. Парсим JSON напрямую в нашу QuickType модель AllStationModel
            let model = try JSONDecoder().decode(AllStationModel.self, from: data)
            
            // 4. МАППИНГ ГОРОДОВ С ФИЛЬТРОМ ПО СТРАНЕ
            let allSettlements = model.countries
                .filter { $0.title == "Россия" } // <--- ДОБАВЛЕН ФИЛЬТР: БЕРЕМ ТОЛЬКО РОССИЮ
                .flatMap { country in
                    country.regions.flatMap { region in
                        region.settlements
                    }
                }
            
            // 5. Преобразуем Settlement в нашу UI-модель CityModel
            let cities = allSettlements.map { CityModel(from: $0) }
            
            // 6. Удаляем дубликаты
            var uniqueCities: [CityModel] = []
            var seenTitles = Set<String>()
            
            for city in cities {
                let uniqueKey = "\(city.title)_\(city.yandexCode ?? "nil")"
                
                if !seenTitles.contains(uniqueKey) {
                    seenTitles.insert(uniqueKey)
                    uniqueCities.append(city)
                }
            }
            
            // 7. Сортируем по алфавиту
            let sortedCities = uniqueCities.sorted { $0.title < $1.title }
            CachedDataManager.shared.saveCities(sortedCities)
                        
        } catch {
            print("Error fetching or decoding allStations: \(error)")
        }
    }
}
#Preview {
    SplashScreen()
}
