//
//  MainView 2.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//
import SwiftUI

struct StoriesView: View {
    let image: String
    let storiesText: String
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .overlay(
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
            
            Text(storiesText)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: 12, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.leading, 20)
                .padding(.bottom, 20)
        }
    }
}
#Preview {
    StoriesView(image: "2", storiesText: "Главная новость на сегодня")
}
