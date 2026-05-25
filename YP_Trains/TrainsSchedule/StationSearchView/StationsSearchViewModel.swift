//
//  StationsSearchViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//
import SwiftUI
import Combine
import OpenAPIURLSession

final class StationsSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    let yaApiKey = Config.shared.getApiKey()

    @Published var allStations: [StationsModel] = []

    let cityName: String
    let lat: String
    let lng: String

    private let onStationSelected: (String) -> Void
    private let onStationSelectedCodes: (String) -> Void
    private var currentFetchTask: Task<Void, Never>?

    init(cityName: String, lat: String, lng: String, onStationSelected: @escaping (String) -> Void, onStationSelectedCodes: @escaping (String) -> Void) {
        self.cityName = cityName
        self.lat = lat
        self.lng = lng
        self.onStationSelected = onStationSelected
        self.onStationSelectedCodes = onStationSelectedCodes
    }

    var filteredStations: [StationsModel] {
        if searchText.isEmpty {
            print("🔍 filteredStations запрошен, отдаем  без фильтра \(allStations.count) станций. Поиск: '\(searchText)'")
            return allStations
        } else {
            print("🔍 filteredStations запрошен, отдаем \(allStations.count) станций. Поиск: '\(searchText)'")
            return allStations.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var isSearchTextEmpty: Bool {
        searchText.isEmpty
    }

    func clearSearch() {
        searchText = ""
    }

    func selectStation(_ station: StationsModel) {
        let finalText = "\(cityName) (\(station.title))"
        onStationSelected(finalText)
        onStationSelectedCodes(station.code)
    }
}

extension StationsSearchViewModel {
    func fetchStations() {
        guard !isLoading else { return }
        print("************** Грузим станции вокруг города *****************")
        isLoading = true
        currentFetchTask?.cancel()

        currentFetchTask = Task {
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

                guard let stationsArray = response.stations else {
                    await MainActor.run {
                        self.allStations = []
                        self.isLoading = false
                    }
                    return
                }

                let mappedStations = stationsArray.map { apiStation in
                    StationsModel(
                        title: apiStation.title ?? "Без названия",
                        code: apiStation.code ?? " ",
                        longitude: apiStation.lng ?? 45.0328,
                        latitude: apiStation.lat ?? 38.9769
                    )
                }
                print("++++++++++++++++++ \(mappedStations.count)+++++++++++++++")
                await MainActor.run {
                    // ПРИНТ 2: Проверяем, что свойство обновилось
                    print("✅ mappedStations обновлен, количество: \(mappedStations.count)")
                  
                    self.allStations = mappedStations
                    
                    print("✅ allStations обновлен, количество: \(self.allStations.count)")
                    print("✅ filteredStations количество: \(self.filteredStations.count)")
                    
                    self.isLoading = false
                }
            } catch {
                print("Error fetching stations: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
