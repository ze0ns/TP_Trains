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
        "Москва", "Санкт-Петербург", "Новосибирск",
        "Екатеринбург", "Казань", "Нижний Новгород",
        "Челябинск", "Самара", "Омск", "Ростов-на-Дону"
    ]
    
    var filteredCities: [String] {
        if searchText.isEmpty { return allCities }
        return allCities.filter { $0.localizedCaseInsensitiveContains(searchText) }
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
            List(filteredCities, id: \.self) { city in
                NavigationLink {
                    StationsSearchView(cityName: city, onStationSelected: onStationSelected)
                } label: {
                    HStack {
                        Text(city)
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
