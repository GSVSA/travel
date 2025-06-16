import Foundation

struct CityData: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let stations: [Station]
}
