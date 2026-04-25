//
//  CopyrightInfoService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession
typealias CopyrightResponse = Components.Schemas.CopyrightResponse

// MARK: - Copyright Info Service
protocol CopyrightInfoServiceProtocol {
    func getCopyrightInfo() async throws -> CopyrightResponse
}

final class CopyrightInfoService: CopyrightInfoServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyrightInfo() async throws -> CopyrightResponse {
        let response = try await client.getCopyrightInfo(query: .init(
            apikey: apikey,
            format: nil
        ))
        return try response.ok.body.json
    }
}

