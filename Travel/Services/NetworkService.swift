import Foundation
import OpenAPIURLSession

protocol NetworkServiceProtocol {
    func searchRoutes(
        from origin: String,
        to destination: String,
        date: String?,
        hasTransfers: Bool?
    ) async throws -> SearchResponse
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
    func getSchedule(station: String) async throws -> ScheduleResponse
    func getCopyright() async throws -> Copyright
    func getRoute(
        uid: String,
        stationCode: StationCode?,
        from origin: String?,
        to destination: String?,
        date: String?
    ) async throws -> Route
    func getCity(lat: Double, lng: Double, distance: Int) async throws -> City
    func getCarriers(code carriersCode: Int) async throws -> Carrier
    func getStationsList() async throws -> StationsList
}

actor NetworkService: NetworkServiceProtocol {
    func searchRoutes(
        from origin: String,
        to destination: String,
        date: String?,
        hasTransfers: Bool?
    ) async throws -> SearchResponse {
        let service = SearchRoutesService(client: try NetworkService.getClient())
        return try await service.searchRoutes(from: origin, to: destination, date: date, hasTransfers: hasTransfers)
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int = 50) async throws -> NearestStations {
        let service = NearestStationsService(client: try NetworkService.getClient())
        return try await service.getNearestStations(lat: lat, lng: lng, distance: distance)
    }
    
    func getSchedule(station: String) async throws -> ScheduleResponse {
        let service = ScheduleService(client: try NetworkService.getClient())
        return try await service.getSchedule(station: station)
    }
    
    func getCopyright() async throws -> Copyright {
        let service = CopyrightService(client: try NetworkService.getClient())
        return try await service.getCopyright()
    }
    
    func getRoute(
        uid: String,
        stationCode: StationCode? = nil,
        from origin: String? = nil,
        to destination: String? = nil,
        date: String? = nil
    ) async throws -> Route {
        let service = RouteService(client: try NetworkService.getClient())
        return try await service
            .getRoute(
                uid: uid,
                stationCode: stationCode,
                from: origin,
                to: destination,
                date: date
            )
    }
    
    func getCity(lat: Double, lng: Double, distance: Int = 50) async throws -> City {
        let service = CityService(client: try NetworkService.getClient())
        return try await service.getCity(lat: lat, lng: lng, distance: distance)
    }
    
    func getCarriers(code carriersCode: Int) async throws -> Carrier {
        let service = CarrierService(client: try NetworkService.getClient())
        return try await service.getCarriers(code: carriersCode)
    }
    
    func getStationsList() async throws -> StationsList {
        let service = StationsListService(client: try NetworkService.getClient())
        return try await service.getStationsList()
    }
    
    private static func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: TravelServiceConstants.apiKey)]
        )
    }
}
