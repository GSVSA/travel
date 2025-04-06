import SwiftUI

private enum TabTags: Int, CaseIterable {
    case mainPage
    case settingsPage
}

struct ContentView: View {
    @State private var selectedTab: TabTags = .mainPage

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                SearchRouteView()
                    .tabItem {
                        Image(systemName: "arrow.up.message")
                    }
                    .tag(TabTags.mainPage)

                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                    }
                    .tag(TabTags.settingsPage)
            }
            .accentColor(.text)
        }
    }
}

#Preview {
    ContentView()
        .modifier(.colorScheme)
        .environmentObject(AppSettings())
}
