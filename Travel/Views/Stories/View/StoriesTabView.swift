import SwiftUI

struct StoriesTabView: View {
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel
    
    var body: some View {
        TabView(selection: $searchRouteViewModel.storyToShowIndex) {
            ForEach(searchRouteViewModel.stories) { story in
                StoryView(story: story)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    StoriesTabView()
        .environmentObject(SearchRouteViewModel())
}
