//
//  MainView 2.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI
struct StoriesView: View {
    var image: UIImage
    var storiesText: String
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .overlay(
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
            
            Text(storiesText)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: 12, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(.leading, 8)
                .padding(.bottom, 12)
        }
    }
}
#Preview {
    StoriesView(image: ._1, storiesText: "Ура аре")
}
