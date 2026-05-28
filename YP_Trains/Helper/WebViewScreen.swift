//
//  WebViewScreen.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 16.05.2026.
//

import SwiftUI

struct WebViewScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = true
    let url: URL
    let title: String
    
    var body: some View {
        ZStack {
            WebView(url: url, isLoading: $isLoading)
            
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .ypBlue))
                .opacity(isLoading ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: isLoading)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.mainTextColor)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}
