import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchRoutesServiceProtocol {
    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse
}

final class SearchRoutesService: SearchRoutesServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func searchRoutes(from origin: String, to destination: String) async throws -> SearchResponse {
        let response = try await client.getSearch(query: .init(
            apikey: apikey,
            from: origin,
            to: destination
        ))
        return try response.ok.body.json
    }
}
