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
            HStack(){
                AsyncImage(url: URL(string: train.iconName)) { image in
                      image
                          .resizable()
                          .frame(width: 38, height: 38)
                  } placeholder: {
                         Image("rzd")
                          .frame(width: 38, height: 38)
                  }
                VStack(alignment: .leading, spacing: 4) {
                    Text(train.operatorName)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black)
                    Text(train.transferName ?? "")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.red)
                }
                Spacer()
                Text(train.transportDate)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
            }
            
            HStack(alignment: .center) {
                Text(train.departureTime)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.black)
                Spacer()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.5))
                Text(train.duration)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .frame(width: 80)
                Spacer()
                    .frame(height: 1)
                    .background(Color.gray.opacity(0.5))
                Text(train.arrivalTime)
                    .font(.system(size: 24, weight: .regular))
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
    TrainCardView(train:TrainScheduleModel(operatorName: "РЖД", iconName: "rzd", carrierCode: 112, transferName: "С пересадкой в Москве",transportDate: "15 февраля", departureTime: "22:30 ", arrivalTime: " 08:15", duration: "9 ч 45 мин"))
}
