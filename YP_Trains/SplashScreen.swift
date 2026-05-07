//
//  SplashScreen.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay {
                Image(.splashScreen)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    TrainsTabView()
                }
            }
    }
}

#Preview {
    SplashScreen()
}
