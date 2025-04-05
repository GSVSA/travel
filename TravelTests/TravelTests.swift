import XCTest
import OpenAPIURLSession
@testable import Travel

final class TravelTests: XCTestCase {
    private func getClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: TravelServiceConstants.apiKey)]
        )
    }

    func testNearestStationsService() async throws {
        let service = NearestStationsService(client: try getClient())
        let stations = try await service.getNearestStations(lat: 55.700765, lng: 37.854746, distance: 1)
        XCTAssertNotNil(stations.stations)
    }

    func testStationsListService() async throws {
        let service = StationsListService(client: try getClient())
        let stations = try await service.getStationsList()
        XCTAssertNotNil(stations.countries)
    }

    func testCityService() async throws {
        let service = CityService(client: try getClient())
        let city = try await service.getCity(lat: 55, lng: 35, distance: 50)
        XCTAssertEqual(city.title, "Тёмкино")
    }

    func testCarrierService() async throws {
        let carriersCode = 680
        let service = CarrierService(client: try getClient())
        let carriers = try await service.getCarriers(code: carriersCode)
        XCTAssertEqual(carriers.carrier?.code, carriersCode)
    }

    func testCopyrightService() async throws {
        let service = CopyrightService(client: try getClient())
        let copyright = try await service.getCopyright()
        XCTAssertEqual(copyright.copyright?.text?.contains("Яндекс.Расписания"), true)
    }

    func testRouteService() async throws {
        let service = RouteService(client: try getClient())
        let route = try await service.getRoute(uid: "7217x7218_0_9600212_g25_4", stationCode: .all)
        XCTAssertNotNil(route.except_days)
    }

    func testScheduleService() async throws {
        let service = ScheduleService(client: try getClient())
        let scheduleResponse = try await service.getSchedule(station: "s9601152")
        XCTAssertNotNil(scheduleResponse.schedule)
    }

    func testSearchRoutesService() async throws {
        let service = SearchRoutesService(client: try getClient())
        let searchResponse = try await service.searchRoutes(from: "s9600212", to: "s9603604")
        XCTAssertNotNil(searchResponse.segments)
        XCTAssertNotNil(searchResponse.search)
    }
}
