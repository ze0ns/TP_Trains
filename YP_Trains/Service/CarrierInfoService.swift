//
//  CarrierInfoService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Информация о перевозчике

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierResponse = Components.Schemas.CarrierResponse


// MARK: - Carrier Info Service
protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(
        code: String,
        system: String,
        lang: String?
    ) async throws -> CarrierResponse
}

final class CarrierInfoService: CarrierInfoServiceProtocol {

    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInfo(
        code: String,
        system: String,
        lang: String?
    ) async throws -> CarrierResponse {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system,
            lang: lang,
            format: "json"
        ))
        return try response.ok.body.json
    }
}

