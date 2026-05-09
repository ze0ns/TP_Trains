//
//  TimeRowView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 09.05.2026.
//
import SwiftUI

// MARK: - Компонент: Строка времени (Чекбокс)
struct TimeRowView: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                .font(.system(size: 22))
                .foregroundColor(isSelected ? Color.ypBlue : Color.gray.opacity(0.4))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle()) 
    }
}
