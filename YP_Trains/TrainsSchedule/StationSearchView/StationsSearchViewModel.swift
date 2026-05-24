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
    @Published var isLoading: Bool = false // Добавляем индикатор загрузки
    
    let yaApiKey = Config.shared.getApiKey()

    @Published var allStations: [StationsModel] = []

    let cityName: String
    let lat: String
    let lng: String

    private let onStationSelected: (String) -> Void
    private let onStationSelectedCodes: (String) -> Void


    init(cityName: String, lat: String, lng: String, onStationSelected: @escaping (String) -> Void, onStationSelectedCodes: @escaping (String) -> Void) {
        self.cityName = cityName
        self.lat = lat
        self.lng = lng
        self.onStationSelected = onStationSelected
        self.onStationSelectedCodes = onStationSelectedCodes
        fetchStations()
    }
    
    var filteredStations: [StationsModel] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func fetchStations() {
        isLoading = true // Включаем индикатор загрузки
        
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = NearestStationsService(
                    client: client,
                    apikey: self.yaApiKey
                )
                
                let response = try await service.getNearestStations(
                    lat: Double(lat) ?? 0,
                    lng: Double(lng) ?? 0,
                    distance: 50
                )

                // 1. Получаем доступ к массиву станций (зависит от структуры вашего OpenAPI клиента)
                guard let stationsArray = response.stations else {
                    // Если данных нет, очищаем список на экране
                    await MainActor.run {
                        self.allStations = []
                        self.isLoading = false // Выключаем индикатор загрузки
                    }
                    return
                }
  
                // 2. Мапим именно массив
                let mappedStations = stationsArray.map { apiStation in
                    StationsModel(
                        title: apiStation.title ?? "Без названия",
                        code: apiStation.code ?? " ",
                        longitude: apiStation.lng ?? 45.0328,
                        latitude: apiStation.lat ?? 38.9769
                    )
                }
  
                // 3. Обновляем UI
                await MainActor.run {
                    self.allStations = mappedStations
                    self.isLoading = false // Выключаем индикатор загрузки
                }
            } catch {
                print("Error fetching stations: \(error)")
                await MainActor.run {
                    self.isLoading = false // Выключаем индикатор загрузки при ошибке
                }
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
        onStationSelectedCodes(station.code)
    }
}
