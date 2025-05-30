import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var appSettings = AppSettings()
    @StateObject private var storiesManager = StoriesManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(.colorScheme)
                .environmentObject(storiesManager)
                .environmentObject(appSettings)
        }
    }
}
