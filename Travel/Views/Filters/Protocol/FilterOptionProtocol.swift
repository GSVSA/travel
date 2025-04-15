import Foundation

protocol FilterOptionProtocol: CaseIterable, Identifiable, Hashable {
    static var title: LocalizedStringResource { get }
    var description: LocalizedStringResource { get }
}
