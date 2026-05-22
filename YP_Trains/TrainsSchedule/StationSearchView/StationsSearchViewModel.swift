//
//  StationsSearchViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//
import SwiftUI
import Combine
import OpenAPIURLSession

final class StationsSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    let yaApiKey = Config.shared.getApiKey()
    
    // 2. Делаем массив Published и изначально пустым
    @Published var allStations: [StationsModel] = []
    
    let cityName: String
    private let onStationSelected: (String) -> Void
    
    init(cityName: String, onStationSelected: @escaping (String) -> Void) {
        self.cityName = cityName
        self.onStationSelected = onStationSelected
    }
    
    // Логика фильтрации (используем .title вместо .name)
    var filteredStations: [StationsModel] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchStations(apiKey: String) {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestStationsService(
                    client: client,
                    apikey: apiKey
                )
                
                print("Fetching stations...")
                let response = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                // 1. Получаем доступ к массиву станций (зависит от структуры вашего OpenAPI клиента)
                guard let stationsArray = response.stations else {
                    // Если данных нет, очищаем список на экране
                    await MainActor.run { self.allStations = [] }
                    return
                }

                // 2. Мапим именно массив
                let mappedStations = stationsArray.map { apiStation in
                    StationsModel(
                        title: apiStation.title ?? "Без названия"
                    )
                }

                // 3. Обновляем UI
                await MainActor.run {
                    self.allStations = mappedStations
                }
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    var isSearchTextEmpty: Bool {
        searchText.isEmpty
    }
    
    func clearSearch() {
        searchText = ""
    }
    
    // 5. Используем .title
    func selectStation(_ station: StationsModel) {
        let finalText = "\(cityName) (\(station.title))"
        onStationSelected(finalText)
    }
}
