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
    var filteredStations: [StationsModel] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Поиск станции...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.textCityColor)
                    }
                }
            }
            .padding(10)
            .background(Color(.ypSearchBg))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            if filteredStations.isEmpty {
                Text("Станция не найдена")
                    .font(.title.bold())
                    .foregroundColor(.textCitySearchColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(filteredStations) { station in
                    Button(action: {
                        let finalText = "\(cityName) (\(station.name))"
                        onStationSelected(finalText)
                    }) {
                        HStack {
                            Text(station.name)
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.backgroundColor)
                }
                .listStyle(PlainListStyle())
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .background(Color.backgroundColor)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    StationsSearchView(cityName: "Москва", onStationSelected:{_ in "Белорусский вокзал"})
}
