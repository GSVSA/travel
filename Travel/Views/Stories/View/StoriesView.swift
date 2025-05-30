import SwiftUI

struct StoriesView: View {
    @EnvironmentObject private var storiesManager: StoriesManager

    @Binding var stories: [StoryModel]
    @Binding var showStory: Bool
    @Binding var currentStoryIndex: Int

    @StateObject private var model: StoriesViewModel

    init(stories: Binding<[StoryModel]>, showStory: Binding<Bool>, currentStoryIndex: Binding<Int>) {
        self._stories = stories
        self._showStory = showStory
        self._currentStoryIndex = currentStoryIndex

        let timerConfiguration = TimerConfiguration(storiesCount: stories.count)
        self._model = StateObject(wrappedValue: StoriesViewModel(timerConfiguration: timerConfiguration))
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    withAnimation {
                        model.saveStoryIndex(currentValue: currentStoryIndex, newValue: newValue)
                    }
                }
                .onTapGesture { location in
                    openNextStory(position: location.x)
                }
                .gesture(
                    DragGesture(minimumDistance: 30)
                        .onEnded { value in
                            if
                                value.translation.height < 30
                                || value.translation.height > 30
                            {
                                closeStory()
                            }
                        }
                )

            CloseButton(action: closeStory)
                .padding(.trailing, 12)
                .padding(.top, 47)

            StoriesProgressBarView(
                storiesCount: stories.count,
                timerConfiguration: model.timerConfiguration,
                currentProgress: $model.currentProgress
            )
            .padding(.top, 7)
            .onChange(of: model.currentProgress) { newValue in
                withAnimation {
                    model.didChangeCurrentProgress(newProgress: newValue, currentStoryIndex: &currentStoryIndex)
                    
                    didStoryShowed()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .padding(.top, 7)
        .padding(.bottom, 17)
        .onAppear {
            withAnimation {
                model.saveStoryIndex(currentValue: currentStoryIndex, newValue: currentStoryIndex)
            }
        }
        .background(
            Color.text
                .ignoresSafeArea(.all)
        )
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func openNextStory(position: CGFloat) {
        guard position > UIScreen.main.bounds.width / 2 else { return }
        
        if currentStoryIndex == stories.count - 1 {
            closeStory()
            return
        }
        
        model.nextStory(
            currentStoryIndex: currentStoryIndex,
            storiesCount: stories.count
        )
    }
    
    private func closeStory() {
        withAnimation(.easeInOut(duration: 0.4)) {
            showStory = false
        }
    }
    
    private func didStoryShowed() {
        storiesManager.markAsShowed(story: stories[currentStoryIndex])
        
        if isLastStoryShowed() {
            closeStory()
        }
    }
    
    private func isLastStoryShowed() -> Bool {
        currentStoryIndex == stories.count - 1
        && model.currentProgress == 1.0
    }
}

#Preview {
    let stories = SearchRouteViewModel().stories
    StoriesView(
        stories: .constant(stories),
        showStory: .constant(false),
        currentStoryIndex: .constant(0)
    )
    .environmentObject(StoriesManager())
}
