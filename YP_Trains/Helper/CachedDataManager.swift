//
//  CachedDataManager.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 23.05.2026.
//
// CachedDataManager.swift
import Foundation
import Combine

class CachedDataManager: ObservableObject {
    static let shared = CachedDataManager()
    
    @Published var cachedData: [CityModel]? = nil
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        // Загружаем данные из кэша при создании
        loadFromCache()
    }
    
    private let citiesCacheKey = "cached_cities"
    private let cacheTimestampKey = "cache_timestamp"
    
    func saveCities(_ cities: [CityModel]) {
        do {
            let data = try JSONEncoder().encode(cities)
            userDefaults.set(data, forKey: citiesCacheKey)
            
            let timestamp = Date()
            userDefaults.set(timestamp, forKey: cacheTimestampKey)
            
            cachedData = cities
            print("Cities cached successfully")
        } catch {
            print("Error saving cities to cache: \(error)")
        }
    }
    
    func getCachedCities() -> [CityModel]? {
        guard let data = userDefaults.data(forKey: citiesCacheKey) else {
            return nil
        }
        
        do {
            let cities = try JSONDecoder().decode([CityModel].self, from: data)
            return cities
        } catch {
            print("Error decoding cached cities: \(error)")
            return nil
        }
    }
    
    func isDataCached() -> Bool {
        return userDefaults.object(forKey: citiesCacheKey) != nil
    }
    
    func isCacheFresh() -> Bool {
        guard let timestamp = userDefaults.object(forKey: cacheTimestampKey) as? Date else {
            return false
        }
        
        let oneDayInSecounds = 120 * 60 * 60
        let interval = Date().timeIntervalSince(timestamp)
        
        return interval < Double(oneDayInSecounds)
    }
    
    private func loadFromCache() {
        if isDataCached(), isCacheFresh() {
            cachedData = getCachedCities()
        }
    }
}
