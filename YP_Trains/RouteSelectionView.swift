//
//  RouteSelectionView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//


import SwiftUI

struct RouteSelectionView: View {
    @State private var fromText: String = ""
    @State private var toText: String = ""
    
    var body: some View {
       
        HStack(spacing: 0) {
            
      
            VStack(spacing: 0) {
                HStack {
                    TextField("Откуда", text: $fromText)
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                
                Divider()
                    .padding(.leading, 16)
                
                HStack {
                    TextField("Куда", text: $toText)
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1.5)
            )
            .padding(.leading, 16)
            .padding(.vertical, 16)
            
            Spacer()
            
            Button(action: {
                let temp = fromText
                withAnimation(.spring()) {
                    fromText = toText
                    toText = temp
                }
            }) {
                Image(.сhange)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .padding(.trailing, 16)
            .padding(.leading, 16)
        }
        .background(Color.ypBlue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue, lineWidth: 1.5)
        )
        .padding(.horizontal, 16)
    }
}


#Preview {
    ZStack {
        Color(UIColor.systemGray6).ignoresSafeArea()
        RouteSelectionView()
    }
}
