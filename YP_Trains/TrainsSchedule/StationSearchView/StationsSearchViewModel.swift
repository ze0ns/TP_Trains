//
//  StationsSearchViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//
import SwiftUI
import Combine

final class StationsSearchViewModel: ObservableObject {
    
    // Состояние поиска
    @Published var searchText: String = ""
    
    // Данные (в реальном приложении здесь был бы вызов NetworkService/Repository)
    private let allStations = [
        StationsModel(name: "Ярославский вокзал"), StationsModel(name: "Казанский вокзал"), StationsModel(name: "Киевский вокзал"),
        StationsModel(name: "Белорусский вокзал"), StationsModel(name: "Савеловский вокзал"), StationsModel(name: "Ленинградский вокзал")
    ]
    
    let cityName: String
    private let onStationSelected: (String) -> Void
    
    init(cityName: String, onStationSelected: @escaping (String) -> Void) {
        self.cityName = cityName
        self.onStationSelected = onStationSelected
    }
    
    // Логика фильтрации перенесена из View
    var filteredStations: [StationsModel] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // Проверка, пуст ли поиск (для отображения кнопки очистки)
    var isSearchTextEmpty: Bool {
        searchText.isEmpty
    }
    
    // Логика очистки поиска
    func clearSearch() {
        searchText = ""
    }
    
    // Логика форматирования и передачи выбранной станции наверх
    func selectStation(_ station: StationsModel) {
        let finalText = "\(cityName) (\(station.name))"
        onStationSelected(finalText)
    }
}
