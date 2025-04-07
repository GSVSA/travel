import SwiftUI

struct DarkModeViewModifier: ViewModifier {
    @ObservedObject var appSettings: AppSettings = AppSettings()
    
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, appSettings.isDarkModeEnabled ? .dark : .light)
            .preferredColorScheme(appSettings.isDarkModeEnabled ? .dark : .light)
    }
}
