import Foundation

struct Station: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let description: StationDescription?
}
