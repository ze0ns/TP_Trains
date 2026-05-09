//
//  ServerErrorView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 09.05.2026.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack(){
            Image(.serverError)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: 233,height: 233)
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ServerErrorView()
}
