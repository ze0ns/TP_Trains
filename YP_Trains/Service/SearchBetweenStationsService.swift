//
//  SearchBetweenStationsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//


//
//  SearchSegmentsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Расписание рейсов по станции

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchSegments = Components.Schemas.Segments

// MARK: - Search Between Stations Service
protocol SearchBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String?,
        transportTypes: String?,
        lang: String?,
        offset: Int?,
        limit: Int?,
        resultTimezone: String?,
        transfers: Bool?
    ) async throws -> SearchSegments
}


    final class SearchBetweenStationsService: SearchBetweenStationsServiceProtocol {
        private let client: Client
        private let apikey: String
        
        init(client: Client, apikey: String) {
            self.client = client
            self.apikey = apikey
            
        }
        
        func getScheduleBetweenStations(
            from: String,
            to: String,
            date: String? = nil,
            transportTypes: String? = nil,
            lang: String? = nil,
            offset: Int? = nil,
            limit: Int? = nil,
            resultTimezone: String? = nil,
            transfers: Bool? = nil
        ) async throws -> SearchSegments {
            let response = try await client.getSchedualBetweenStations(query: .init(
                apikey: apikey,
                from: from,
                to: to,
                format: nil,
                lang: lang,
                date: date,
                transport_types: transportTypes,
                offset: offset,
                limit: limit,
                result_timezone: resultTimezone,
                transfers: transfers
            ))
            return try response.ok.body.json
        }
    }

