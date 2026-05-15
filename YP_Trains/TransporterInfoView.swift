//
//  TransporterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 15.05.2026.
//


import SwiftUI

struct TransporterInfoView: View {
    @Binding var routeTrains: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            // MARK: - Логотип и название
            VStack(alignment: .leading, spacing: 24) {
                
                Image(.rzdIcon)
                
                Text("ОАО «РЖД»")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 24)
                
                InfoRow(title: "E-mail", value: "info@rzd.ru")
                InfoRow(title: "Телефон", value: "8 (800) 200-67-67")
            }
            .padding(.horizontal, 16)
            .padding(.top, 40)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundColor)
     
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true) // Скрываем стандартную кнопку
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
               
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black) 
                        .font(.system(size: 17, weight: .semibold))
                }
            }
        }
    }
}


// Для предпросмотра
#Preview {
    NavigationStack {
        TransporterInfoView(routeTrains: .constant("Москва - Санкт-Петербург"))
    }
}
