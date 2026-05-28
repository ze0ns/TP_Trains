//
//  StationScheduleService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Расписание рейсов по станции


import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

// MARK: - Station Schedule Service
protocol StationScheduleServiceProtocol {
    func getStationSchedule(
        station: String,
        date: String?,
        transportTypes: String?,
        event: String?,
        direction: String?,
        lang: String?,
        system: String?,
        resultTimezone: String?
    ) async throws -> ScheduleResponse
}

final class StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationSchedule(
        station: String,
        date: String? = nil,
        transportTypes: String? = nil,
        event: String? = nil,
        direction: String? = nil,
        lang: String? = nil,
        system: String? = nil,
        resultTimezone: String? = nil
    ) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            lang: lang,
            format: nil,
            date: date,
            transport_types: transportTypes,
            event: event,
            direction: direction,
            system: system,
            result_timezone: resultTimezone
        ))
        return try response.ok.body.json
    }
}
