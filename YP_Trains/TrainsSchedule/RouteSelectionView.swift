//
//  RouteSelectionView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//


import SwiftUI

enum ActiveField: Identifiable {
    case from, to
    var id: String { self == .from ? "from" : "to" }
}

struct RouteSelectionView: View {
    @Binding var fromText: String
    @Binding var toText: String
    
    @State private var activeField: ActiveField?
    
    var body: some View {
        HStack(spacing: 0) {
            
            VStack(spacing: 0) {
                Button {
                    activeField = .from
                } label: {
                    HStack {
                        Text(fromText)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                .buttonStyle(.plain)
                
                Divider()
                    .padding(.leading, 16)
                
                Button {
                    activeField = .to
                } label: {
                    HStack {
                        Text(toText)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                .buttonStyle(.plain)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 1.5)
            )
            .padding(.leading, 16)
            .padding(.vertical, 16)
            
            Spacer()
            
            Button(action: {
                let temp = fromText
                withAnimation(.spring()) {
                    fromText = toText
                    toText = temp
                }
            }) {
                Image(.сhange)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .padding(.trailing, 16)
            .padding(.leading, 16)
        }
        .background(Color.ypBlue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue, lineWidth: 1.5)
        )
        .padding(.horizontal, 16)
        
        .fullScreenCover(item: $activeField) { field in
            NavigationStack {
                CitySearchView(onStationSelected: { selectedStation in
                    if field == .from {
                        fromText = selectedStation
                    } else {
                        toText = selectedStation
                    }
                    activeField = nil
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            activeField = nil
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .semibold))
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ZStack {
        Color(UIColor.systemGray6).ignoresSafeArea()
        RouteSelectionView(fromText: .constant("Откуда"), toText: .constant("Куда"))
    }
}
