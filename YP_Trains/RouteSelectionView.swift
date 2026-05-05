//
//  RouteSelectionView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//


import SwiftUI

struct RouteSelectionView: View {
    @State private var fromText: String = "Откуда"
    @State private var toText: String = "Куда"
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
             
                HStack {
                    TextField("Откуда", text: $fromText)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Divider()
                    .padding(.leading, 16)
                
                HStack {
                    TextField("Куда", text: $toText)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            
 
            Button(action: {
                let temp = fromText
                withAnimation(.spring()) {
                    fromText = toText
                    toText = temp
                }
            }) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
            }
            .padding(.trailing, 12)
        }
    
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue, lineWidth: 1.5) // Синяя обводка
        )
        .padding(.horizontal)
    }
}


#Preview {
    ZStack {
        Color(UIColor.systemGray6).ignoresSafeArea()
        RouteSelectionView()
    }
}
