//
//  StoryPlayerView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 16.05.2026.
//

import SwiftUI
import Combine

struct StoryPlayerView: View {
    let stories: [StoriesItem]
    @State var selectedIndex: Int
    
    @Environment(\.dismiss) private var dismiss
    @State private var timerProgress: Float = 0.0
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Черный фон на весь экран (красный для дебага, можете вернуть Color.black)
                Color.red.ignoresSafeArea()
                
                let currentStory = stories[selectedIndex]
                let cardWidth = geometry.size.width
                let cardHeight = geometry.size.height
                
                ZStack(alignment: .bottom) {
                    // Сама картинка
                    Image(uiImage: currentStory.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                    
                    // Затемнение снизу для текста
                    VStack(alignment: .leading, spacing: 8) {
                        Text(currentStory.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
    
                        Text(currentStory.description)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                    .frame(width: cardWidth, alignment: .leading)
                    .background(
                        LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    )
                }
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                VStack {
                    Spacer(minLength: 50) // Оставляем место сверху для прогресса и крестика!
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                goToPreviousStory()
                            }
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                goToNextStory()
                            }
                    }
                    Spacer(minLength: 17) // Снизу упираемся в край картинки
                }
                .padding(.horizontal, 16)
                
                // СЛОЙ 3: Прогресс и Кнопка закрытия (САМЫЙ ВЕРХНИЙ СЛОЙ!)
                VStack(spacing: 0) {
                    VStack() {
                        // Полоски прогресса
                        HStack(spacing: 4) {
                            ForEach(stories.indices, id: \.self) { index in
                                ProgressView(value: index == selectedIndex ? timerProgress : (index < selectedIndex ? 1.0 : 0.0))
                                    .progressViewStyle(LinearProgressViewStyle(tint: .progressBarFill))
                                    .background(Color.white)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, 28)
                        .padding(.leading, 12)
                        .padding(.trailing, 12)
                        HStack(alignment: .bottom){
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
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
        }
    }
    
    private func updateProgress() {
        timerProgress += 0.01
        
        if timerProgress >= 1.0 {
            goToNextStory()
        }
    }
    
    private func goToNextStory() {
        if selectedIndex < stories.count - 1 {
            selectedIndex += 1
            timerProgress = 0.0
        } else {
            dismiss()
        }
    }
    
    private func goToPreviousStory() {
        if selectedIndex > 0 {
            selectedIndex -= 1
            timerProgress = 0.0
        } else {
            timerProgress = 0.0
        }
    }
}
