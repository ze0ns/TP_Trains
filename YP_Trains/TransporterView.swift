//
//  TransporterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 07.05.2026.
//

import SwiftUI


struct TrainScheduleView: View {
    // Моковые данные для расписания
    let trains: [TrainScheduleModel] = [
        TrainScheduleModel(operatorName: "РЖД", iconName: "rzd",transportDate: "15 февраля", departureTime: "22:30", arrivalTime: "08:15", duration: "9 ч 45 мин") ,
        TrainScheduleModel(operatorName: "ФГК",iconName: "ural",transportDate: "16 февраля", departureTime: "23:00", arrivalTime: "08:15", duration: "9 ч 15 мин"),
        TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk",transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин"),
        TrainScheduleModel(operatorName: "РЖД", iconName: "ural",transportDate: "18 февраля", departureTime: "00:10", arrivalTime: "08:40", duration: "8 ч 30 мин")
    ]
    
    @Binding var routeTrains: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Фон
            Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // MARK: - Заголовок
                VStack(alignment: .leading, spacing: 8) {
                    Text(routeTrains)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
    
                
                // MARK: - Список поездов
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(trains) { train in
                            TrainCardView(train: train)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 16)
                    // Отступ снизу, чтобы кнопка не перекрывала контент
                    .padding(.bottom, 100)
                }
            }
            
            // MARK: - Нижняя кнопка
            VStack {
                Button(action: {
                    print("Уточнить время нажата")
                }) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.ypBlue)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16) // Учитываем safe area
            }
            .background(.ultraThinMaterial) // Размытый фон под кнопкой как в реальных приложениях
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Поезда")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
    }
}



#Preview {
    NavigationView {
        TrainScheduleView(routeTrains: .constant("Москва — Санкт-Петербург"))
    }
}


