import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Route = Components.Schemas.Route
typealias StationCode = Operations.getRoute.Input.Query.show_systemsPayload

protocol RouteServiceProtocol {
    func getRoute(
        uid: String,
        stationCode: StationCode?,
        from origin: String?,
        to destination: String?,
        date: String?
    ) async throws -> Route
}

actor RouteService: RouteServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getRoute(
        uid: String,
        stationCode: StationCode? = nil,
        from origin: String? = nil,
        to destination: String? = nil,
        date: String? = nil
    ) async throws -> Route {
        let response = try await client.getRoute(query: .init(
            uid: uid,
            from: origin,
            to: destination,
            date: date,
            show_systems: stationCode
        ))
        return try response.ok.body.json
    }
}
