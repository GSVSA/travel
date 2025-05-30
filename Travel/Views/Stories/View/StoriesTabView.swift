import SwiftUI

struct StoriesTabView: View {
    let stories: [StoryModel]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories) { story in
                StoryView(story: story)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    let stories = SearchRouteViewModel().stories
    StoriesTabView(stories: stories, currentStoryIndex: .constant(0))
}
