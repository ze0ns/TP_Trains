//
//  StoryPlayerView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 16.05.2026.
//

import SwiftUI
import Combine

struct StoryPlayerView: View {
    // 1. Принимаем Binding на массив, чтобы менять isViewed
    @Binding var stories: [StoriesItem]
    @State var selectedIndex: Int
    
    @Environment(\.dismiss) private var dismiss
    @State private var timerProgress: Float = 0.0
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    // 2. Инициализатор для поиска нужного индекса по ID
    init(stories: Binding<[StoriesItem]>, initialStoryId: Int) {
        self._stories = stories
        // Находим индекс сторис по её ID
        let index = stories.wrappedValue.firstIndex(where: { $0.id == initialStoryId }) ?? 0
        self._selectedIndex = State(initialValue: index)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()
                
                let currentStory = stories[selectedIndex]
                let cardWidth = geometry.size.width
                let cardHeight = geometry.size.height
                
                ZStack(alignment: .bottom) {
                    Image(uiImage: currentStory.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(currentStory.title)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(currentStory.description)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 40)
                    .frame(width: cardWidth, alignment: .leading)
                    .background(
                        LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                // Зоны нажатия
                VStack {
                    Spacer(minLength: 50)
                    HStack(spacing: 0) {
                        Rectangle().foregroundColor(.clear).contentShape(Rectangle())
                            .onTapGesture { goToPreviousStory() }
                        Rectangle().foregroundColor(.clear).contentShape(Rectangle())
                            .onTapGesture { goToNextStory() }
                    }
                    Spacer(minLength: 17)
                }
                
                // Прогресс бар и кнопка закрытия
                VStack(spacing: 0) {
                    VStack {
                        HStack(spacing: 4) {
                            ForEach(stories.indices, id: \.self) { index in
                                let progress = index == selectedIndex ? timerProgress : (index < selectedIndex ? 1.0 : 0.0)
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        Capsule().fill(Color.white)
                                        Capsule().fill(Color.progressBarFill)
                                            .frame(width: geo.size.width * CGFloat(progress))
                                    }
                                }
                                .frame(height: 6)
                            }
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 12)
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                            .padding(.top, 7)
                            .padding(.trailing, 16)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .statusBarHidden(true)
            .onReceive(timer) { _ in
                updateProgress()
            }
            // 3. Как только открылась сторис — сразу помечаем её как просмотренную!
            .onAppear {
                markAsViewed()
            }
        }
    }
    
    private func updateProgress() {
        timerProgress += 0.01
        
        if timerProgress >= 1.0 {
            goToNextStory()
        }
    }
    
    // 4. Функция отметки просмотра
    private func markAsViewed() {
        if !stories[selectedIndex].isViewed {
            stories[selectedIndex].isViewed = true
        }
    }
    
    private func goToNextStory() {
        if selectedIndex < stories.count - 1 {
            selectedIndex += 1
            timerProgress = 0.0
            markAsViewed() // Отмечаем новую сторис
        } else {
            dismiss()
        }
    }
    
    private func goToPreviousStory() {
        if selectedIndex > 0 {
            selectedIndex -= 1
            timerProgress = 0.0
            // Предыдущая сторис уже просмотрена, но можно вызвать markAsViewed() для надежности
        } else {
            timerProgress = 0.0
        }
    }
}
