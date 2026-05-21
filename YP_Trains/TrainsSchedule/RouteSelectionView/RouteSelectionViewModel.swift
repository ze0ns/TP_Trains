//
//  RouteSelectionViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine

// MARK: - Enums
enum ActiveField: String, Identifiable {
    case from, to
    var id: String { rawValue }
}

final class RouteSelectionViewModel: ObservableObject {
    
    @Published var fromText: String = "Откуда"
    @Published var toText: String = "Куда"
    @Published var activeField: ActiveField?
    let cityViewModel = CityViewModel()
    

    func swapCities() {
        let temp = fromText
        withAnimation(.spring()) {
            fromText = toText
            toText = temp
        }
    }

    func selectStation(_ station: String) {
        guard let field = activeField else { return }
        
        switch field {
        case .from:
            fromText = station
        case .to:
            toText = station
        }
        closeSearch()
    }
    
    func showSearch(for field: ActiveField) {
        activeField = field
    }
    
    func closeSearch() {
        activeField = nil
    }
}
