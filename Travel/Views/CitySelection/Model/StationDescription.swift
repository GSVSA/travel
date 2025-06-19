import Foundation

enum StationDescription: String, Equatable, CaseIterable {
    case train = "train_station"
    case airport = "airport"
    case busStation = "bus_station"
    case riverPort = "river_port"
    case seaPort = "marine_station"
    case station = "station"
    
    var description: String {
        switch self {
        case .train: String(localized: "train station")
        case .airport: String(localized: "airport")
        case .busStation: String(localized: "bus station")
        case .riverPort: String(localized: "river port")
        case .seaPort: String(localized: "sea port")
        case .station: String(localized: "station")
        }
    }
}
