//
//  RouteFilterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 09.05.2026.
//

import SwiftUI

struct RouteFilterView: View {

    @State private var selectedTimeSlots: Set<String> = ["Утро", "Ночь"]
    @State private var showTransfers: Bool = false
    
   
    var showButtonApply: Bool {
        !selectedTimeSlots.isEmpty
    }
    
    let timeSlots = [
        ("Утро", "06:00 - 12:00"),
        ("День", "12:00 - 18:00"),
        ("Вечер", "18:00 - 00:00"),
        ("Ночь", "00:00 - 06:00")
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(UIColor.white).ignoresSafeArea()
            
            // MARK: - Контент
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Время отправления")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 16)
                        .padding(.leading, 16) // <--- ДОБАВЬТЕ ЭТУ СТРОКУ
                    
                    VStack(spacing: 0) {
                        ForEach(timeSlots, id: \.0) { (name, time) in
                            TimeRowView(
                                title: name,
                                subtitle: time,
                                isSelected: selectedTimeSlots.contains(name)
                            )
                            .onTapGesture {
                                toggleTime(name)
                            }
                        }
                    }
                    .cornerRadius(16)
                  
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading, spacing: 24) {
                            RadioButtonView(title: "Да", isSelected: showTransfers) {
                                showTransfers = true
                            }
                            RadioButtonView(title: "Нет", isSelected: !showTransfers) {
                                showTransfers = false
                            }
                            Spacer()
                        }
                    }
                    .padding(16)
                    .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, showButtonApply ? 100 : 20)
            }
            

            if showButtonApply {
                VStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.ypBlue)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showButtonApply)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private func toggleTime(_ name: String) {
        if selectedTimeSlots.contains(name) {
            selectedTimeSlots.remove(name)
        } else {
            selectedTimeSlots.insert(name)
        }
    }
}



#Preview {
    RouteFilterView()
}
