//
//  SplashScreen.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = true
    var body: some View {
        if isActive {
            Color.black
                .ignoresSafeArea()
                .overlay {
                    Image(.splashScreen)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        isActive = false
                    }
                }
        } else {
            TrainsTabView()
        }
    }
}

#Preview {
    SplashScreen()
}
