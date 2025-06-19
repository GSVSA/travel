import Foundation

struct FilterTime: Hashable, Identifiable, Sendable {
    let id = UUID()
    let time: DayTime
    var isSelected: Bool
}
