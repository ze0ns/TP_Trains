//
//  StoryPlayerView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 16.05.2026.
//

import SwiftUI
import Combine

struct StoryPlayerView: View {
    @ObservedObject var viewModel: StoryPlayerViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()
                
                let cardWidth = geometry.size.width
                let cardHeight = geometry.size.height
                
                // MARK: - Контент (Картинка + Текст)
                ZStack(alignment: .bottom) {
                    Image(uiImage: viewModel.currentStory.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.currentStory.title)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(viewModel.currentStory.description)
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
                .contentShape(Rectangle())
                .onTapGesture { location in
                    // Передаем относительную координату X (от 0.0 до 1.0)
                    let relativeX = location.x / geometry.size.width
                    viewModel.handleTap(relativeX: relativeX)
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 30, coordinateSpace: .local)
                        .onEnded { value in
                            viewModel.handleSwipe(
                                dx: value.translation.width,
                                dy: value.translation.height
                            )
                        }
                )
                
                // MARK: - Прогресс бар и кнопка закрытия
                VStack(spacing: 0) {
                    VStack {
                        HStack(spacing: 4) {
                            ForEach(viewModel.stories.indices, id: \.self) { index in
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        Capsule().fill(Color.white)
                                        Capsule().fill(Color.progressBarFill)
                                            .frame(width: geo.size.width * CGFloat(viewModel.progress(for: index)))
                                    }
                                }
                                .frame(height: 6)
                            }
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 12)
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            Button(action: { viewModel.close() }) {
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
            .onAppear {
                viewModel.markAsViewed()
            }
            // Реакция на запрос закрытия от ViewModel
            .onChange(of: viewModel.shouldDismiss) { _, shouldDismiss in
                if shouldDismiss {
                    dismiss()
                }
            }
        }
    }
}
