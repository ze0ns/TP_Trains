//
//  ContentView.swift
//  YP_Trains
//
//  Created by Oschepkov Aleksandr on 25.04.2026.
//

import SwiftUI
import OpenAPIURLSession

struct ServiceView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            fetchStations()
          //  fetchSearchBetween()
//            fetchStationSchedule()
//            fetshAllStations()
//            fetshCarrierInfoService()
//            fetshCopyrightInfo()
//            fetshNearestCityInfo()
//            fetRouteStationsInfo()
        }
    }
}
//MARK: Methods
func fetchStations() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = NearestStationsService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            
            print("Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            
            print("Successfully fetched stations: \(stations)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
func fetchSearchBetween() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = SearchBetweenStationsService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            
            print("Fetching shedule...")
            let schedule = try await service.getScheduleBetweenStations(
                from: "c146",
                to: "c213",
                date: "2026-04-30"
            )
            print("Successfully fetched stations: \(schedule)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
func fetchStationSchedule() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = StationScheduleService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            
            print("Fetching StaitionShedule...")
            let schedule = try await service.getStationSchedule(
                station: "s9600213",
                date: "2026-04-30",
                transportTypes: "train",
                event: "departure",
                direction: nil,
                lang: "ru_RU",
                system: nil,
                resultTimezone: "Europe/Moscow"
            )
            
            print("Successfully fetched StaitionShedule: \(schedule)")
        } catch {
            print("Error fetching StaitionShedule: \(error)")
        }
    }
}
func fetshAllStations() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = AllStationsService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            print("Fetching allStations...")
            let allStations = try await service.getAllStations()
            print("Successfully fetched allStations: \(allStations)")
        } catch {
            print("Error fetching allStations: \(error)")
        }
    }
}

func fetshCarrierInfoService() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = CarrierInfoService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            print("Fetching carrierInfo...")
            let carrierInfo = try await service.getCarrierInfo(code: "tk", system: "iata", lang: "ru_RU")
            print("Successfully fetched carrierInfo: \(carrierInfo)")
        } catch {
            print("Error fetching carrierInfo: \(error)")
        }
    }
}
func fetshCopyrightInfo() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = CopyrightInfoService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            print("Fetching copyrightInfo...")
            let copyrightInfo = try await service.getCopyrightInfo()
            print("Successfully fetched copyrightInfo: \(copyrightInfo)")
        } catch {
            print("Error fetching copyrightInfo: \(error)")
        }
    }
}
func fetshNearestCityInfo() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = NearestCityService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            print("Fetching cityServiceInfo...")
            let cityServiceInfo = try await service.getNearestCity(
                lat: 50.440046,
                lng: 40.4882367,
                distance: 50,
                lang: "ru_RU")
            print("Successfully fetched cityServiceInfo: \(cityServiceInfo)")
        } catch {
            print("Error fetching cityServiceInfo: \(error)")
        }
    }
}
func fetRouteStationsInfo() {
    Task {
        do {
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = RouteStationsService(
                client: client,
                apikey: "7b909b55-e269-4f2b-b30a-44ba9b3f2c3d"
            )
            print("Fetching routeInfo...")
            let routeInfo = try await service.getRouteStations(
                uid: "098S_1_2",
                date:"2026-04-27",
                lang: "ru_RU",
                showSystems: "all")
            print("Successfully fetched stations: \(routeInfo)")
        } catch {
            print("Error fetching routeInfo: \(error)")
        }
    }
}

#Preview {
    ServiceView()
}
