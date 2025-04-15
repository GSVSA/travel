import Foundation

private let mockStations = [
    "Киевский вокзал",
    "Московский вокзал",
]

final class StationsListViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    @Published var searchText: String = ""

    let stations = mockStations

    var searchResult: [String] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    func selectStation(station: String, from city: String, withStationData stationData: inout StationData) {
        stationData.city = city
        stationData.station = station
    }
}
