//
//  TrainsSchedulerViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine

@MainActor
final class TrainsSchedulerViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Published var storiesItems: [StoriesItem] = [
        StoriesItem(id: 0, backgroundImage: ._1, title: "Text Text Text Text Text Text Text Text Te", description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "),
        StoriesItem(id: 1, backgroundImage: ._2, title: "Text Text Text Text Text Text Text Text Te", description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "),
        StoriesItem(id: 2, backgroundImage: ._3, title: "Text Text Text Text Text Text Text Text Te", description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "),
        StoriesItem(id: 3, backgroundImage: ._4, title: "Text Text Text Text Text Text Text Text Te", description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ")
    ]
    
    @Published var showTransporter: Bool = false
    @Published var routeTrains: String = ""
    @Published var selectedStory: StoriesItem?
    
    let routeViewModel = RouteSelectionViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        routeViewModel.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    var isFormFilled: Bool {
        routeViewModel.fromText != "Откуда" && routeViewModel.toText != "Куда"
    }
    
    var sortedStories: [StoriesItem] {
        storiesItems.sorted { !$0.isViewed && $1.isViewed }
    }
    
    func searchRoutes() {
        showTransporter = true
    }
}
