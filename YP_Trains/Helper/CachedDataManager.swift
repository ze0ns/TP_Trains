//
//  CachedDataManager.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 23.05.2026.
//  CachedDataManager.swift

import Foundation

final class CachedDataManager {
    static let shared = CachedDataManager()
    
    private let hour: Double = 24
    private let minutes: Double = 60
    private let seconds: Double = 60
    
    private let fileManager = FileManager.default
    private let citiesCacheFileName = "cached_cities.json"
    
    // MARK: - Путь к файлу кэша
    private var cacheFileURL: URL {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cachesDirectory.appendingPathComponent(citiesCacheFileName)
    }
    
    private init() {}
    
    // MARK: - Сохранение
    func saveCities(_ cities: [CityModel]) {
        do {
            let data = try JSONEncoder().encode(cities)
            try data.write(to: cacheFileURL, options: .atomicWrite)
            print("Cities cached successfully to file")
        } catch {
            print("Error saving cities to file: \(error)")
        }
    }
    
    // MARK: - Чтение
    func getCachedCities() -> [CityModel]? {
        guard fileManager.fileExists(atPath: cacheFileURL.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: cacheFileURL)
            let cities = try JSONDecoder().decode([CityModel].self, from: data)
            return cities
        } catch {
            print("Error decoding cached cities from file: \(error)")
            return nil
        }
    }
    
    // MARK: - Проверки
    func isDataCached() -> Bool {
         fileManager.fileExists(atPath: cacheFileURL.path)
    }
    
    func isCacheFresh() -> Bool {
        guard let attributes = try? fileManager.attributesOfItem(atPath: cacheFileURL.path),
              let modificationDate = attributes[.modificationDate] as? Date else {
            return false
        }
        
        let oneDayInSeconds: Double = hour * minutes * seconds
        let interval = Date().timeIntervalSince(modificationDate)
        
        return interval < oneDayInSeconds
    }

    func clearCacheIfNeeded() {
        if isDataCached() && !isCacheFresh() {
            try? fileManager.removeItem(at: cacheFileURL)
            print("Old cache removed")
        }
    }
}
