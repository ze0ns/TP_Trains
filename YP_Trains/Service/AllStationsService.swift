//
//  AllStationsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Список всех доступных станций

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

protocol AllStationsServiceProtocol {
    func getAllStations() async
}


actor AllStationsService: AllStationsServiceProtocol {

    private let client: Client
    private let apikey: String

    private let yaApiKey = Config.shared.getApiKey()
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    

    func getAllStations() async {
        do {
            let urlString = "https://api.rasp.yandex.net/v3.0/stations_list/?apikey=\(yaApiKey)&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Ошибка: неверный URL")
                return
            }
            
            print("Fetching allStations via URLSession...")
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Ошибка: сервер вернул не 200")
                return
            }
            
            let model = try JSONDecoder().decode(AllStationModel.self, from: data)
            
            let allSettlements = model.countries
                .filter { $0.title == "Россия" }
                .flatMap { country in
                    country.regions.flatMap { region in
                        region.settlements
                    }
                }
            
            let cities = allSettlements.map { CityModel(from: $0) }
            
            var uniqueCities: [CityModel] = []
            var seenTitles = Set<String>()
            
            for city in cities {
                let uniqueKey = "\(city.title)_\(city.yandexCode ?? "nil")"
                
                if !seenTitles.contains(uniqueKey) {
                    seenTitles.insert(uniqueKey)
                    uniqueCities.append(city)
                }
            }
            
            let sortedCities = uniqueCities.sorted { $0.title < $1.title }
            
            CachedDataManager.shared.saveCities(sortedCities)
                        
        } catch {
            print("Error fetching or decoding allStations: \(error)")
        }
    }
}
