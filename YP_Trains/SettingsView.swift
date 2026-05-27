//
//  SettingsView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 15.05.2026.
//


//
//  SettingsView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 15.05.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(spacing: 16) {
            
            Toggle("Темная тема", isOn: $isDarkMode)
                .tint(.ypBlue)
                .foregroundColor(.mainTextColor)
                .onChange(of: isDarkMode) { oldValue, newValue in
                    print("Тема изменена на: \(newValue ? "темную" : "светлую")")
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
            
            NavigationLink(destination: WebViewScreen(
                url: URL(string: "https://yandex.ru/legal/practicum_offer")!,
                title: "Пользовательское соглашение"
            )) {
                HStack {
                    Text("Пользовательское соглашение")
                        .foregroundColor(.mainTextColor)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.mainTextColor.opacity(0.7))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            Spacer()
            
            Text("Версия 1.0 (beta)")
                .foregroundColor(.mainTextColor.opacity(0.7))
                .font(.footnote)
                .padding(.bottom, 24)
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationTitle("Настройки")
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

#Preview {
    NavigationStack {
        SettingsView()
    }
}
