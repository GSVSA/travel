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

    init(client: Client) {
        self.client = client
    }

    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList()
        let httpBody = try response.ok.body.html
        let stationList = try await JSONDecoder().decode(from: httpBody, to: StationsList.self)
        return stationList
    }
}
