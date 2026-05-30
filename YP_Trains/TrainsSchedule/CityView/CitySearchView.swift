//
//  CitySearchView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//
import SwiftUI

struct CitySearchView: View {
    @StateObject var viewModel: CityViewModel
    let onStationSelected: (String) -> Void
    let onStationSelectedCodes: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Поиск города...", text: $viewModel.searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                if !viewModel.searchText.isEmpty {
                    Button(action: viewModel.clearSearch) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.textCityColor)
                    }
                }
            }
            .padding(10)
            .background(Color(.ypSearchBg))
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            if viewModel.filteredCities.isEmpty {
                Text("Город не найден")
                    .font(.title.bold())
                    .foregroundColor(.textCitySearchColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.filteredCities) { city in
                    NavigationLink {
                        LazyView {
                            StationsSearchView(viewModel: StationsSearchViewModel(
                                cityName: city.title,
                                lat: city.latitude,
                                lng: city.longitude,
                                onStationSelected: onStationSelected,
                                onStationSelectedCodes: onStationSelectedCodes
                            ))
                        }
                    } label: {
                        HStack {
                            Text(city.title)
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
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        // ДОБАВЛЕНО: Запускаем фильтрацию при каждом изменении текста
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.filterCities()
        }
    }
}

#Preview {
    CitySearchView(viewModel: CityViewModel(), onStationSelected: {_ in "Москва"}, onStationSelectedCodes: {_ in "c213"})
}
