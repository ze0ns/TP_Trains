//
//  LazyView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.05.2026.
//
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    var body: some View {
        build()
    }
}
