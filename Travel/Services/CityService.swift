import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias City = Components.Schemas.City

protocol CityServiceProtocol {
    func getCity(lat: Double, lng: Double, distance: Int) async throws -> City
}

final class CityService: CityServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getCity(
        lat: Double,
        lng: Double,
        distance: Int
    ) async throws -> City {
        let response = try await client.getCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
