import Foundation

struct Filters: Sendable {
    var departureTime: [FilterTime] = [
        FilterTime(time: .morning, isSelected: false),
        FilterTime(time: .afternoon, isSelected: false),
        FilterTime(time: .evening, isSelected: false),
        FilterTime(time: .night, isSelected: false)
    ]
    var withTransfers: Bool?
    var isSelected: Bool {
        withTransfers != nil
    }
}
