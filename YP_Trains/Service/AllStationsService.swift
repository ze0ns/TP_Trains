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
    func getAllStations() async throws -> AllStationsResponse
}

final class AllStationsService: AllStationsServiceProtocol {

    private let client: Client
    private let apikey: String
    var fullData = Data()
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations() async throws -> AllStationsResponse {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey
        ))
        let limit = 10*1024*1024 //10 MB
        let responseBody = try response.ok.body.html
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        let allStations = try JSONDecoder().decode(AllStationsResponse.self, from: fullData)
        return allStations
    }
}
