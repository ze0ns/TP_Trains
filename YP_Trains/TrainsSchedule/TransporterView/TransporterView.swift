//
//  TransporterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 07.05.2026.
//

import SwiftUI
import Combine

// MARK: - View
struct TransporterView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TransporterViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(Color.backgroundColor).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    headerSection
                    
                    trainsList
                }
                
                bottomButton
            }
            .fullScreenCover(isPresented: $viewModel.showFilter) {
                RouteFilterView(viewModel: viewModel.routeFilterViewModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
        }
    }
}

// MARK: - Subviews
private extension TransporterView {
    
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.routeTrains)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.mainTextColor)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    var trainsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.trains) { train in
                    TrainCardView(train: train)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 16)
            .padding(.bottom, 100)
        }
    }
    
    var bottomButton: some View {
        VStack {
            Button(action: {
                viewModel.openFilter()
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
    
    var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color.textCityColor)
        }
    }
}

#Preview {
    TransporterView(viewModel: TransporterViewModel(routeTrains: "Москва —> Санкт-Петербург"))
}
