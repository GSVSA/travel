import Foundation

//private let mockCities: [CityData] = ["Москва", "Санкт-Петербург", "Волгоград", "Минеральные воды"]

final class CitySelectionViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isError: NetworkErrorType? = nil
    @Published var selectedCity: CityData = CityData(id: "", name: "", stations: [])
    @Published var searchText: String = ""
    @Published var isCitySelected: Bool = false
    
    private let networkService: some NetworkServiceProtocol = NetworkService()
    private var cities: [CityData] = []

    var searchResult: [CityData] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    func selectCity(_ city: CityData) {
        selectedCity = city
        isCitySelected = true
    }
    
    func fetchCities() async {
        await MainActor.run {
            isLoading = true
            isError = nil
        }
        
        var stationsFullList: StationsList
        
        do {
            stationsFullList = try await networkService.getStationsList()
        }
        catch {
            await MainActor.run {
                isLoading = false
                isError = .noInternetConnection
            }
            return
        }
        
        let stationsList = stationsFullList.countries?.first {
            $0.codes?.yandex_code == TravelServiceConstants.apiScheduleCountryRussiaId
        }
        
        guard let regionStationsList = stationsList?.regions else {
            await MainActor.run {
                isLoading = false
                isError = .serverError
            }
            return
        }
        
        let cityList: [CityData] = getCityList(regionStationsList: regionStationsList)
        
        await MainActor.run { [cityList] in
            cities = cityList
            isLoading = false
            isError = nil
        }
    }
    
    private func getCityList(regionStationsList: [Components.Schemas.Region]) -> [CityData] {
        var cityList: [CityData] = []
        
        regionStationsList.compactMap { $0.settlements }.forEach { settlements in
            settlements.forEach { settlement in
                guard
                    let id = settlement.codes?.yandex_code,
                    let title = settlement.title
                else {
                    return
                }
                
                var stations: [Station] = []
                settlement.stations?.forEach { station in
                    if
                        let stationId = station.codes?.yandex_code,
                        let stationName = station.title,
                        StationDescription.allCases.contains(where: { element in
                            return element.rawValue.lowercased() == station.station_type?.lowercased() ?? ""
                        })
                    {
                        var description: StationDescription? = nil
                        if let stationType = station.station_type {
                            description = StationDescription.init(rawValue: stationType)
                        }
                        stations.append(Station(id: stationId, name: stationName, description: description))
                    }
                }
                if !stations.isEmpty {
                    cityList.append(CityData(id: id, name: title, stations: stations))
                }
            }
        }
        
        return cityList
    }
}
