//
//  MainView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct TrainsSchedulerView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var storiesItems = [
        StoriesItem(id: 0, backgroundImage: ._1, title: "Text Text Text Text Text Text Text Text Te", description: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 "),
        StoriesItem(id: 1, backgroundImage: ._2, title: "Text Text Text Text Text Text Text Text Te", description: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 "),
        StoriesItem(id: 2, backgroundImage: ._3, title: "Text Text Text Text Text Text Text Text Te", description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 "),
        StoriesItem(id: 3, backgroundImage: ._4, title: "Text Text Text Text Text Text Text Text Te", description: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 ")
    ]
    
    @State private var fromText: String = "Откуда"
    @State private var toText: String = "Куда"
    @State private var showTransporter = false
    @State private var routeTrains: String = ""
    @State private var selectedStory: StoriesItem?
    
    var isFormFilled: Bool {
        fromText != "Откуда" && toText != "Куда"
    }
    
    var sortedStories: [StoriesItem] {
        storiesItems.sorted { !$0.isViewed && $1.isViewed }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(sortedStories) { item in
                            VStack {
                                StoriesView(image: item.backgroundImage, storiesText: item.title)
                            }
                            .frame(width: 92, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(item.isViewed ? Color.gray.opacity(0.5) : Color.ypBlue, lineWidth: 4)
                            }
                            .opacity(item.isViewed ? 0.6 : 1.0)
                            .onTapGesture {
                                selectedStory = item
                            }
                        }
                    }
                    .padding(.top, 3)
                    .padding(.horizontal, 16)
                    .padding(.bottom)
                }
                .padding(.top, 24)
                
                RouteSelectionView(fromText: $fromText, toText: $toText)
                    .padding(.top, 44)
                
                if isFormFilled {
                    Button(action: {
                        routeTrains = fromText + " -> " + toText
                        print(routeTrains)
                        showTransporter = true
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
                
                Spacer()
            }
            .background(Color.backgroundColor)
            .fullScreenCover(isPresented: $showTransporter) {
                TransporterView(routeTrains: $routeTrains)
            }
            .fullScreenCover(item: $selectedStory) { story in
                StoryPlayerView(stories: $storiesItems, initialStoryId: story.id)
            }
            .animation(.easeInOut(duration: 0.3), value: isFormFilled)
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .animation(.easeInOut(duration: 0.3), value: isDarkMode)
    }
}

#Preview {
    TrainsSchedulerView()
}
