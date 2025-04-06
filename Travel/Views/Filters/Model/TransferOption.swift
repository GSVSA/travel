import Foundation

enum TransferOption: FilterOptionProtocol {
    static let title: LocalizedStringResource = "Show options with transfers"

    var id: String { UUID().uuidString }

    case yes
    case no

    var description: LocalizedStringResource {
        switch self {
        case .yes: return "Yes"
        case .no: return "No"
        }
    }
}
