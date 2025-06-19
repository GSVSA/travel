import SwiftUI

struct StoriesListView: View {
    @EnvironmentObject private var storiesManager: StoriesManager
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel

    private let rows = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                ForEach(searchRouteViewModel.stories) { story in
                    StoryPreviewView(story: story)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .onTapGesture(coordinateSpace: .global) { _ in
                            onTapAction(story: story)
                        }
                        .opacity(storiesManager.isStoryShowed(story: story) ? 0.5 : 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(.accent, lineWidth: 4)
                                .opacity(storiesManager.isStoryShowed(story: story) ? 0 : 1)
                        )
                }
            }
        }
        .frame(maxHeight: 188)
        .scrollIndicators(.never)
    }

    private func onTapAction(story: StoryModel) {
        withAnimation(.easeInOut(duration: 0.4)) {
            searchRouteViewModel.showStory = true
            searchRouteViewModel.storyToShowIndex = story.id
        }
    }
}

#Preview {
    StoriesListView()
        .environmentObject(StoriesManager())
        .environmentObject(SearchRouteViewModel())
}
