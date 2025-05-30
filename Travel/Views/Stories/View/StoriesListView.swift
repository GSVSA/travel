import SwiftUI

struct StoriesListView: View {
    @EnvironmentObject private var storiesManager: StoriesManager

    let stories: [StoryModel]
    let rows = [GridItem(.flexible())]

    @Binding var showStory: Bool
    @Binding var selectedStory: Int

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center, spacing: 12) {
                ForEach(stories) { story in
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
            showStory = true
            selectedStory = story.id
        }
    }
}

#Preview {
    let stories = SearchRouteViewModel().stories
    StoriesListView(
        stories: stories,
        showStory: .constant(true),
        selectedStory: .constant(1)
    )
    .environmentObject(StoriesManager())
}
