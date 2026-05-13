//
//  TrainsTabView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//

import SwiftUI

struct TrainsTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Group {
                if selectedTab == 0 {
                    ZStack {
                        TrainsSchedulerView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                } else {
                    ZStack {
                        Color.white.ignoresSafeArea()
                        Text("Вью с настройками")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }

            
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.tabLineColor)
                    .frame(height: 2)
                
                HStack(spacing: 0) {
                    Button(action: {
                        selectedTab = 0
                    }) {
                        Label("", image: .schedule)
                            .foregroundColor(selectedTab == 0 ? .tabColor : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        selectedTab = 1
                    }) {
                        Label("", image: .settings)
                            .foregroundColor(selectedTab == 1 ? .tabColor : .gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .background(Color.backgroundColor)
            }
        }
    }
}
#Preview {
    TrainsTabView()
}
