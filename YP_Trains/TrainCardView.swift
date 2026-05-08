//
//  TrainCardView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 08.05.2026.
//

import SwiftUI

struct TrainCardView: View {
    let train: TrainScheduleModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Название оператора
            HStack(){
                Image(train.iconName)
                    .frame(width: 38, height: 38)
                Text(train.operatorName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                Text(train.transportDate)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
            }
            // Время и маршрут
            HStack(alignment: .top) {
                // Отправление
                
                Text(train.departureTime)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                // Время в пути (по центру)
                VStack(spacing: 4) {
                    Text(train.duration)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .frame(width: 80) // Фиксированная ширина для центрирования
                
                Spacer()
                
                
                
                Text(train.arrivalTime)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
            }
        }
        .padding(16)
        .background(Color.ypLiteGray)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    TrainCardView(train:TrainScheduleModel(operatorName: "РЖД", iconName: "rzd",transportDate: "15 февраля", departureTime: "22:30", arrivalTime: "08:15", duration: "9 ч 45 мин"))
}
