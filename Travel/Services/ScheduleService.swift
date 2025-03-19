import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getSchedule(station: String) async throws -> ScheduleResponse {
        let response = try await client.getSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
