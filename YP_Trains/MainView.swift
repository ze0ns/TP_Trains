//
//  MainView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct MainView: View {
    let storiesItems = [StoriesItem(imageName: "1", storiesText: "Новость 1"),
                        StoriesItem(imageName: "2", storiesText: "Новость 2"),
                        StoriesItem(imageName: "3", storiesText: "Новость 3"),
                        StoriesItem(imageName: "4", storiesText: "Новость 4")]

    var body: some View {
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
            
            RouteSelectionView()
                .padding(.top, 44)
            Spacer()
 
        }
    }
}
#Preview {
    MainView()
}
