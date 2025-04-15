import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var appSettings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(.colorScheme)
                .environmentObject(appSettings)
        }
    }
}
