import Foundation

private let mockCities = ["Москва", "Санкт-Петербург", "Волгоград", "Минеральные воды"]

final class CitySelectionViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    @Published var searchText: String = ""
    @Published var selectedCity: String = "" {
        didSet {
            isCitySelected = !selectedCity.isEmpty
        }
    }
    @Published var isCitySelected: Bool = false

    private let cities = mockCities

    var searchResult: [String] {
        guard !searchText.isEmpty else { return cities }
        return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    func selectCity(_ city: String) {
        selectedCity = city
    }
}
