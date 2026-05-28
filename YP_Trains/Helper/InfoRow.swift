//
//  InfoRow.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 15.05.2026.
//

import SwiftUI
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            Text(value)
                .font(.body)
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
