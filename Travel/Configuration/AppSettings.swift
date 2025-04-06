import SwiftUI

final class AppSettings: ObservableObject {
    @AppStorage("darkMode") var isDarkModeEnabled: Bool = false

    var appVersion: String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }
}
