//
//  StoryPlayerViewModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 21.05.2026.
//


import SwiftUI
import Combine

final class StoryPlayerViewModel: ObservableObject {
    
    // Состояния, которые отслеживает View
    @Published var stories: [StoriesItem]
    @Published var selectedIndex: Int
    @Published var timerProgress: Float = 0.0
    @Published var shouldDismiss: Bool = false
    
    // Замыкания для связи с родительским экраном
    var onStoriesUpdated: (([StoriesItem]) -> Void)?
    
    // Таймер и подписки
    private let timerPublisher = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()
    
    init(stories: [StoriesItem], initialStoryId: Int) {
        self.stories = stories
        self.selectedIndex = stories.firstIndex(where: { $0.id == initialStoryId }) ?? 0
        
        subscribeToTimer()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Computed Properties
    var currentStory: StoriesItem {
        stories[selectedIndex]
    }
    
    func progress(for index: Int) -> Float {
        if index == selectedIndex {
            return timerProgress
        } else if index < selectedIndex {
            return 1.0
        } else {
            return 0.0
        }
    }
    
    // MARK: - Timer Logic
    private func subscribeToTimer() {
        timerPublisher
            .sink { [weak self] _ in
                self?.updateProgress()
            }
            .store(in: &cancellables)
    }
    
    private func updateProgress() {
        guard !shouldDismiss else { return }
        
        timerProgress += 0.01
        
        if timerProgress >= 1.0 {
            goToNextStory()
        }
    }
    
    // MARK: - Business Logic
    func markAsViewed() {
        if !stories[selectedIndex].isViewed {
            stories[selectedIndex].isViewed = true
            onStoriesUpdated?(stories) // Сообщаем родителю об изменениях сразу
        }
    }
    
    func goToNextStory() {
        if selectedIndex < stories.count - 1 {
            selectedIndex += 1
            timerProgress = 0.0
            markAsViewed()
        } else {
            close()
        }
    }
    
    func goToPreviousStory() {
        if selectedIndex > 0 {
            selectedIndex -= 1
            timerProgress = 0.0
        } else {
            timerProgress = 0.0
        }
    }
    
    func close() {
        onStoriesUpdated?(stories) // Финальная отправка данных родителю
        shouldDismiss = true
    }
    
    // MARK: - User Actions (Делегирование от View)
    func handleTap(relativeX: Double) {
        if relativeX < 0.5 {
            goToPreviousStory()
        } else {
            goToNextStory()
        }
    }
    
    func handleSwipe(dx: Double, dy: Double) {
        if abs(dy) > abs(dx) {
            if dy > 0 {
                close() // Свайп вниз
            }
        } else {
            if dx < 0 {
                goToNextStory() // Свайп влево
            } else {
                goToPreviousStory() // Свайп вправо
            }
        }
    }
}