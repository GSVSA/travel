import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias City = Components.Schemas.City

protocol CityServiceProtocol {
    func getCity(lat: Double, lng: Double, distance: Int) async throws -> City
}

final class CityService: CityServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCity(
        lat: Double,
        lng: Double,
        distance: Int
    ) async throws -> City {
        let response = try await client.getCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
