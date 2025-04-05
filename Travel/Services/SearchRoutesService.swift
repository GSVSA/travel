import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchRoutesServiceProtocol {
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse
}

final class SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let response = try await client.getSearch(query: .init(
            from: origin,
            to: destination
        ))
        return try response.ok.body.json
    }
}
