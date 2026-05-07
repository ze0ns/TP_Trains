//
//  City.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//


import SwiftUI

struct CitySearchView: View {
    let onStationSelected: (String) -> Void // Переименовали замыкание
    
    @State private var searchText = ""
    
    let allCities = [
      CityModel(name: "Москва"), CityModel(name: "Санкт-Петербург"), CityModel(name: "Краснодар"), CityModel(name: "Казань"), CityModel(name: "Пермь"),  CityModel(name: "Екатеренбург"),  CityModel(name: "Сочи")
    ]
    
    var filteredCities: [CityModel] {
        if searchText.isEmpty { return allCities }
        return allCities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Строка поиска
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Поиск города...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // Список городов
            List(filteredCities) { city in
                NavigationLink {
                    StationsSearchView(cityName: city.name, onStationSelected: onStationSelected)
                } label: {
                    HStack {
                        Text(city.name)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .scrollDismissesKeyboard(.interactively)
            
            if filteredCities.isEmpty {
                Spacer()
                Text("Город не найден")
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .navigationTitle("Выбор города")
    }
}

#Preview {
    CitySearchView(onStationSelected: {_ in "Москва"})
}
