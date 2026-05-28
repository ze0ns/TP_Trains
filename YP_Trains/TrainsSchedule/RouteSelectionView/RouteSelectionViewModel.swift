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
    
    @Published var fromStationsCode: String = "c146"
    @Published var toStationsCode: String = "c213"
    
    @Published var activeField: ActiveField?
    
    let cityViewModel = CityViewModel()
    
    func swapCities() {
        let tempText = fromText
        let tempCode = fromStationsCode
        
        withAnimation(.spring()) {
            fromText = toText
            toText = tempText
            
            fromStationsCode = toStationsCode
            toStationsCode = tempCode
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
    }
    
    func saveCode(_ code: String) {
        guard let field = activeField else { return }
        
        switch field {
        case .from:
            fromStationsCode = code
        case .to:
            toStationsCode = code
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
