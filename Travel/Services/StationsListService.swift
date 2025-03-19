import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsList = Components.Schemas.StationsList
typealias NotFoundResponse = Components.Schemas.NotFoundResponse

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

struct NotFoundError: Error {
    let response: NotFoundResponse
}

struct ResponseOtherError: Error {
    let response: String
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        let httpBody = try response.ok.body.html
        let stationList = try await JSONDecoder().decode(from: httpBody, to: StationsList.self)
        return stationList
    }
}
