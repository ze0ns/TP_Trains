//
//  StationsSearchView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//
import SwiftUI
import Combine

struct StationsSearchView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: StationsSearchViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            if viewModel.isLoading {
                Spacer()
                ProgressView("Загрузка станций...")
                    .padding()
                Spacer()
            } else if viewModel.filteredStations.isEmpty {
                emptyStateView
            } else {
                stationsList
            }
        }
        .background(Color.backgroundColor)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {

            viewModel.fetchStations()
        }
    }
}

// MARK: - Subviews (Вынесено для чистоты основного body)
private extension StationsSearchView {
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Поиск станции...", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !viewModel.isSearchTextEmpty {
                Button(action: {
                    viewModel.clearSearch()
                }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(.textCityColor)
                }
            }
        }
        .padding(10)
        .background(Color(.ypSearchBg))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    var emptyStateView: some View {
        Text("Станция не найдена")
            .font(.title.bold())
            .foregroundColor(.textCitySearchColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var stationsList: some View {
        List(viewModel.filteredStations) { station in
            Button(action: {
                viewModel.selectStation(station)
            }) {
                HStack {
                    Text(station.title)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.backgroundColor)
        }
        .listStyle(PlainListStyle())
        .scrollDismissesKeyboard(.interactively)
    }
}

#Preview {
    StationsSearchView(viewModel: StationsSearchViewModel(cityName: "Москва", lat: " 55,75", lng: "37,61", onStationSelected: { _ in }))
}
