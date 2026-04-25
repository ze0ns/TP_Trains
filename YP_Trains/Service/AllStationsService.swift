//
//  AllStationsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession
typealias AllStationsResponse = Components.Schemas.AllStationsResponse

// MARK: - All Stations Service
protocol AllStationsServiceProtocol {
    func getAllStations(lang: String?) async throws -> AllStationsResponse
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations(lang: String? = nil) async throws -> AllStationsResponse {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey,
            lang: lang,
            format: nil
        ))
        return try response.ok.body.json
    }
}
