//
//  MainView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct TrainsSchedulerView: View {
    let storiesItems = [StoriesItem(imageName: "1", storiesText: "Новость 1"),
                        StoriesItem(imageName: "2", storiesText: "Новость 2"),
                        StoriesItem(imageName: "3", storiesText: "Новость 3"),
                        StoriesItem(imageName: "4", storiesText: "Новость 4")]
    
    @State private var fromText: String = "Откуда"
    @State private var toText: String = "Куда"
    
    @State private var showTransporter = false
    @State private var routeTrains: String = ""
    
    var isFormFilled: Bool {
        fromText != "Откуда" && toText != "Куда"
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(storiesItems.indices, id: \.self) { index in
                            let item = storiesItems[index]
                            VStack() {
                                StoriesView(image: item.imageName, storiesText: item.storiesText)
                            }
                            .frame(width: 92, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.ypBlue, lineWidth: 4)
                            }
                            .opacity(index >= 2 ? 0.5 : 1.0)
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
                        routeTrains = fromText + " - " + toText
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
            .navigationDestination(isPresented: $showTransporter) {
                TransporterView(routeTrains: $routeTrains)
            }
            .animation(.easeInOut(duration: 0.3), value: isFormFilled)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TrainsSchedulerView()
}
