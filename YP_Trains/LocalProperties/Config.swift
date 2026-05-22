//
//  Config.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 22.05.2026.
//

import Foundation

class Config {
    static let shared = Config()
    
    private var plist: [String: Any]!
    
    private init() {
        guard let url = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: url) as? [String: Any] else {
            fatalError("Failed to load Config.plist")
        }
        plist = dict
    }
    
    func getApiKey() -> String {
        return plist["API_KEY"] as? String ?? ""
    }
}
