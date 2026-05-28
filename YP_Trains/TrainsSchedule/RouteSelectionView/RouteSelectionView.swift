//
//  RouteSelectionView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//


import SwiftUI
import Combine

struct RouteSelectionView: View {
    @ObservedObject var viewModel: RouteSelectionViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            fieldsStack
            swapButton
        }
        .background(Color.ypBlue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.ypBlue.opacity(0.8), lineWidth: 1.5)
        )
        .padding(.horizontal, 16)
        .fullScreenCover(item: $viewModel.activeField) { field in
            searchScreen(field: field)
        }
    }
}

// MARK: - Subviews
private extension RouteSelectionView {
    
    var fieldsStack: some View {
        VStack(spacing: 0) {
            Button {
                viewModel.showSearch(for: .from)
            } label: {
                HStack {
                    Text(viewModel.fromText)
                        .font(.system(size: 16))
                        .foregroundColor(viewModel.fromText == "Откуда" ? .ypGrayUni : .black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .buttonStyle(.plain)
            
            Divider()
                .padding(.leading, 16)
            
            Button {
                viewModel.showSearch(for: .to)
            } label: {
                HStack {
                    Text(viewModel.toText)
                        .font(.system(size: 16))
                        .foregroundColor(viewModel.toText == "Куда" ? .ypGrayUni : .black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .buttonStyle(.plain)
        }
        .background(Color.ypCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1.5)
        )
        .padding(.leading, 16)
        .padding(.vertical, 16)
    }
    
    var swapButton: some View {
        Button(action: {
            viewModel.swapCities()
        }) {
            Image(.сhange)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.ypBlue)
                .frame(width: 36, height: 36)
                .background(Color.ypCardBackground)
                .clipShape(Circle())
        }
        .padding(.trailing, 16)
        .padding(.leading, 16)
    }
    
    func searchScreen(field: ActiveField) -> some View {
        NavigationStack {
            CitySearchView(viewModel: viewModel.cityViewModel) { selectedStation in
                viewModel.selectStation(selectedStation)
            } onStationSelectedCodes: { codeString in
                viewModel.saveCode(codeString)
                print("Получен код: \(codeString)")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.closeSearch()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.textCityColor)
                    }
                }
            }
            .background(Color.backgroundColor)
        }
    }
}

#Preview {
    ZStack {
        Color(UIColor.systemGray6).ignoresSafeArea()
        RouteSelectionView(viewModel: RouteSelectionViewModel())
    }
}
