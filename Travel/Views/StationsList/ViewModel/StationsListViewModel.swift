import Foundation

@MainActor
final class StationsListViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var isError: NetworkErrorType? = nil
    @Published var searchText: String = ""

    var searchResult: [Station] {
        guard !searchText.isEmpty else { return stations }
        return stations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private var stations: [Station] = []

    func selectStation(
        station: Station,
        from city: CityData,
        withStationData stationData: inout StationData?
    ) {
        guard let stationLocalData = stationData else { return }
        stationData = StationData(
            stationType: stationLocalData.stationType,
            city: city.name,
            station: station
        )
    }
    
    func setStations(stationsList: [Station]) {
        self.stations = stationsList
        self.isLoading = false
    }
}
