//
//  RouteStationsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Список станций следования

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadStationsResponse = Components.Schemas.ThreadStationsResponse

// MARK: - Route Stations Service
protocol RouteStationsServiceProtocol {
    func getRouteStations(
        uid: String,
        from: String?,
        to: String?,
        date: String?,
        lang: String?,
        showSystems: String?
    ) async throws -> ThreadStationsResponse
}

actor RouteStationsService: RouteStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil,
        lang: String? = nil,
        showSystems: String? = nil
    ) async throws -> ThreadStationsResponse {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid,
            from: from,
            to: to,
            format: nil,
            lang: lang,
            date: date,
            show_systems: showSystems
        ))
        return try await response.ok.body.json
    }
}
