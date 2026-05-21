//
//  MainView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct TrainsSchedulerView: View {
    @StateObject private var viewModel = TrainsSchedulerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                storiesSection
                RouteSelectionView(viewModel: viewModel.routeViewModel)
                    .padding(.top, 44)
                
                if viewModel.isFormFilled {
                    searchButton
                }
                
                Spacer()
            }
            .background(Color.backgroundColor)
            .fullScreenCover(isPresented: $viewModel.showTransporter) {
                TransporterView(
                    viewModel: TransporterViewModel(
                        routeTrains: viewModel.routeViewModel.fromText + " -> " + viewModel.routeViewModel.toText
                    )
                )
            }
            .fullScreenCover(item: $viewModel.selectedStory) { story in
                StoryPlayerView(stories: $viewModel.storiesItems, initialStoryId: story.id)
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.isFormFilled)
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isDarkMode)
    }
}

// MARK: - Subviews
private extension TrainsSchedulerView {
    
    var storiesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.sortedStories) { item in
                    VStack {
                        StoriesView(image: item.backgroundImage, storiesText: item.title)
                    }
                    .frame(width: 92, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(item.isViewed ? Color.clear : Color.ypBlue, lineWidth: 4)
                    }
                    .opacity(item.isViewed ? 0.6 : 1.0)
                    .onTapGesture {
                        viewModel.selectedStory = item
                    }
                }
            }
            .padding(.top, 3)
            .padding(.horizontal, 16)
            .padding(.bottom)
        }
        .padding(.top, 24)
    }
    
    var searchButton: some View {
        Button(action: {
            viewModel.searchRoutes()
        }) {
            Text("Найти")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 150, height: 60)
                .background(Color.ypBlue)
                .cornerRadius(16)
        }
        .padding(.top, 16)
        .frame(maxWidth: .infinity)
        .padding(.bottom, 40)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    TrainsSchedulerView()
}
