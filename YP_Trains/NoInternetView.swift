//
//  NoInternetView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 09.05.2026.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack(){
            Image(.noInternet)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: 233,height: 233)
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    NoInternetView()
}
