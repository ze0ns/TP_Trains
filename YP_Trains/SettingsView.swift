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
        Form {
            // Секция внешнего вида
            Section(header: Text("Внешний вид")) {
                Toggle("Темная тема", isOn: $isDarkMode)
                    .tint(.ypBlue) // Цвет переключателя в стиле вашего приложения
            }
            
            // Секция общего
            Section(header: Text("Общее")) {
                NavigationLink(destination: Text("Пользовательское сообщение")) {
                    Text("Пользовательское сообщество")
                }

            }
            
            // Секция "О приложении" (внизу)
            Section {
                HStack {
                    Spacer()
                    Text("Версия 1.0 (beta)")
                        .foregroundColor(.secondary)
                        .font(.footnote)
                    Spacer()
                }
            }
        }
        // Кастомная навигация (черная стрелка назад)
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black) // В темной теме можно сделать .primary
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
