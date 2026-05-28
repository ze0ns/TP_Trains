//
//  SettingsView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 15.05.2026.
//

import SwiftUI


struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            
            Toggle("Темная тема", isOn: $viewModel.isDarkMode)
                .tint(.ypBlue)
                .foregroundColor(.mainTextColor)
                .padding(.horizontal, 16)
                .padding(.top, 24)
           
            userAgreementLink
            Spacer()
            
            Text("Версия \(viewModel.appVersion)")
                .foregroundColor(.mainTextColor.opacity(0.7))
                .font(.footnote)
                .padding(.bottom, 24)
        }
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationTitle("Настройки")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
    
    // MARK: - Subviews
    private var userAgreementLink: some View {
        Group {
            if let url = viewModel.userAgreementURL {
                NavigationLink(destination: WebViewScreen(
                    url: url,
                    title: viewModel.userAgreementTitle
                )) {
                    userAgreementRow
                }
            } else {
                userAgreementRow
                    .opacity(0.5)
            }
        }
    }
    
    private var userAgreementRow: some View {
        HStack {
            Text(viewModel.userAgreementTitle)
                .foregroundColor(.mainTextColor)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.mainTextColor.opacity(0.7))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundStyle(Color.mainTextColor)
                .font(.system(size: 17, weight: .semibold))
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
