//
//  StoriesModel.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 05.05.2026.
//

import Foundation

struct StoriesItem: Identifiable {
    let id = UUID()
    let imageName: String
    let storiesText: String
}
