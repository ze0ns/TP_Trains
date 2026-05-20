//
//  RouteFilterView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 06.05.2026.
//
import SwiftUI

struct RouteFilterView: View {
    @ObservedObject var viewModel: RouteFilterViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(Color.backgroundColor).ignoresSafeArea()
                
                // MARK: - Контент
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Время отправления")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.mainTextColor)
                            .padding(.top, 16)
                            .padding(.leading, 16)
                        
                        VStack(spacing: 0) {
                            ForEach(viewModel.timeSlots, id: \.0) { (name, time) in
                                TimeRowView(
                                    title: name,
                                    subtitle: time,
                                    isSelected: viewModel.selectedTimeSlots.contains(name)
                                )
                                .onTapGesture {
                                    viewModel.toggleTime(name)
                                }
                            }
                        }
                        .cornerRadius(16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Показывать варианты с пересадками")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.mainTextColor)
                            
                            VStack(alignment: .leading, spacing: 24) {
                                RadioButtonView(title: "Да", isSelected: viewModel.showTransfers) {
                                    viewModel.setShowTransfers(true)
                                }
                                RadioButtonView(title: "Нет", isSelected: !viewModel.showTransfers) {
                                    viewModel.setShowTransfers(false)
                                }
                                Spacer()
                            }
                        }
                        .padding(16)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, viewModel.showButtonApply ? 100 : 20)
                }
                
                if viewModel.showButtonApply {
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
            .animation(.easeInOut(duration: 0.25), value: viewModel.showButtonApply)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.textCityColor)
                    }
                }
            }
        }
    }
}

#Preview {
    RouteFilterView(viewModel: RouteFilterViewModel())
}
