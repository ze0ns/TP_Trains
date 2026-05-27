//
//  NearestStationsService.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//  Список ближайших станций

import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

actor  NearestStationsService: NearestStationsServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
    let response = try await client.getNearestStations(query: .init(
        apikey: apikey,     // Передаём API-ключ
        lat: lat,           // Передаём широту
        lng: lng,           // Передаём долготу
        distance: distance  // Передаём дистанцию
    ))
      return try await response.ok.body.json
  }
}
