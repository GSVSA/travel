import Foundation

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

actor CopyrightService: CopyrightServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright()
        return try response.ok.body.json
    }
}
