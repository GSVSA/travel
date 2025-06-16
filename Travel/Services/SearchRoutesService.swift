import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.SearchResponse
typealias RouteSegments = Components.Schemas.SearchResponse.segmentsPayload

protocol SearchRoutesServiceProtocol {
    func searchRoutes(from origin: String, to destination: String, date: String?, hasTransfers: Bool?) async throws -> SearchResponse
}

actor SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func searchRoutes(from origin: String, to destination: String, date: String?, hasTransfers: Bool?) async throws -> SearchResponse {
        let response = try await client.getSearch(query: .init(
            from: origin,
            to: destination,
            date: date,
            transfers: hasTransfers
        ))
        return try response.ok.body.json
    }
}
