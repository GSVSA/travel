import Foundation

enum StationType: String {
    case from
    case to
    
    var prompt: String {
        let localized = String.LocalizationValue(self.rawValue)
        return String(localized: localized)
    }
}
