//
//  StationsSearchView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import SwiftUI

struct StationsSearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    let cityName: String
    let onStationSelected: (String) -> Void
   
    let allStations = [
        StationsModel(name: "Ярославский вокзал"), StationsModel(name: "Казанский вокзал"), StationsModel(name: "Киевский вокзал"),
        StationsModel(name: "Белорусский вокзал"), StationsModel(name: "Савеловский вокзал"), StationsModel(name: "Ленинградский вокзал")

    ]
    var filteredStations: [String] {
        if searchText.isEmpty {
            return allStations.map { $0.name }
        } else {
            return allStations.filter { $0.name.localizedCaseInsensitiveContains(searchText) } as! [String]
        }
    }
    
    var body: some View {
            VStack(spacing: 0) {
                // Строка поиска
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Поиск станции...", text: $searchText)
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
                
                // Список станций
                List(filteredStations, id: \.self) { station in
                    Button(action: {
                        // Формируем итоговую строку: "Город, Станция"
                        let finalText = "\(cityName), \(station)"
                        onStationSelected(finalText)
                    }) {
                        HStack {
                            Text(station)
                        }
                        .padding(.vertical, 4)
                    }
                    .foregroundColor(.black)
                }
                .listStyle(PlainListStyle())
                .scrollDismissesKeyboard(.interactively)
                
                if filteredStations.isEmpty {
                    Spacer()
                    Text("Станция не найдена")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Станции: \(cityName)")
        }
}

#Preview {
    StationsSearchView(cityName: "Москва", onStationSelected:{_ in "Белорусский вокзал"})
}
