//
//  NearestCityService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession


typealias NearestCityResponse = Components.Schemas.NearestCityResponse

// MARK: - Nearest City Service
protocol NearestCityServiceProtocol {
    func getNearestCity(
        lat: Double,
        lng: Double,
        distance: Int?,
        lang: String?
    ) async throws -> NearestCityResponse
}

final class NearestCityService: NearestCityServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestCity(
        lat: Double,
        lng: Double,
        distance: Int? = nil,
        lang: String? = nil
    ) async throws -> NearestCityResponse {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance,
            lang: lang,
            format: nil
        ))
        return try response.ok.body.json
    }
}
