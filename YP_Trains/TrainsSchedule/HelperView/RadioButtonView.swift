//
//  RadioButtonView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 09.05.2026.
//

import SwiftUI

struct RadioButtonView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Color.ypBlue : Color.gray.opacity(0.4))
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.black)
            }
        }
    }
}
