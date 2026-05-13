//
//  TransporterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 07.05.2026.
//

import SwiftUI


struct TransporterView: View {
    // Моковые данные для расписания
    let trains: [TrainScheduleModel] = [
        TrainScheduleModel(operatorName: "РЖД", iconName: "rzd", transferName: "С пересадкой в Костроме",transportDate: "15 февраля", departureTime: "22:30", arrivalTime: "08:15", duration: "9 ч 45 мин") ,
        TrainScheduleModel(operatorName: "ФГК",iconName: "ural", transferName: "С пересадкой в Москве",transportDate: "16 февраля", departureTime: "23:00", arrivalTime: "08:15", duration: "9 ч 15 мин"),
        TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин"),
        TrainScheduleModel(operatorName: "РЖД", iconName: "ural", transferName: nil, transportDate: "18 февраля", departureTime: "00:10", arrivalTime: "08:40", duration: "8 ч 30 мин"),
        TrainScheduleModel(operatorName: "Урал логистика", iconName: "fgk", transferName: nil, transportDate: "17 февраля", departureTime: "23:55", arrivalTime: "09:30", duration: "9 ч 35 мин")
    ]
    
    @State private var showFilter = false
    @Environment(\.dismiss) var dismiss
    @Binding var routeTrains: String
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(Color.backgroundColor).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // MARK: - Заголовок
                    VStack(alignment: .leading, spacing: 8) {
                        Text(routeTrains)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.mainTextColor)
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
                        .padding(.bottom, 100)
                    }
                    
                }
                
                // MARK: - Нижняя кнопка
                VStack {
                    Button(action: {
                        showFilter = true
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
                    .padding(.bottom, 16)
                }
                .background(.clear)
            }
            .fullScreenCover(isPresented: $showFilter) {
                RouteFilterView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color.textCityColor)
                    }
                }
            }
        }
    }
}



#Preview {
    NavigationView {
        TransporterView(routeTrains: .constant("Москва —> Санкт-Петербург"))
    }
}


