import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarriers(code: Int) async throws -> Carrier
}

actor CarrierService: CarrierServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }
    
    func getCarriers(code: Int) async throws -> Carrier {
        let response = try await client.getCarriers(query: .init(
            code: code
        ))
        return try response.ok.body.json
    }
}
