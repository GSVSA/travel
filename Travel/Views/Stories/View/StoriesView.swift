import SwiftUI

struct StoriesView: View {
    @EnvironmentObject private var storiesManager: StoriesManager
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel
    
    @StateObject private var model = StoriesViewModel()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView()
                .onChange(of: searchRouteViewModel.storyToShowIndex) { newValue in
                    withAnimation {
                        model.saveStoryIndex(currentValue: searchRouteViewModel.storyToShowIndex, newValue: newValue)
                    }
                }
                .onTapGesture { location in
                    openNextStory(position: location.x)
                }
                .gesture(
                    DragGesture(minimumDistance: 30)
                        .onEnded { value in
                            if value.translation.height != 30 {
                                closeStory()
                            }
                        }
                )

            CloseButton(action: closeStory)
                .padding(.trailing, 12)
                .padding(.top, 47)

            StoriesProgressBarView()
                .environmentObject(model)
                .environmentObject(searchRouteViewModel)
                .padding(.top, 7)
                .onChange(of: model.currentProgress) { newValue in
                    withAnimation {
                        model.didChangeCurrentProgress(newProgress: newValue, currentStoryIndex: &searchRouteViewModel.storyToShowIndex)
                        
                        didStoryShowed()
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .padding(.top, 7)
        .padding(.bottom, 17)
        .onAppear {
            model.setupTimerConfiguration(storiesCount: searchRouteViewModel.stories.count)

            withAnimation {
                model.saveStoryIndex(currentValue: searchRouteViewModel.storyToShowIndex, newValue: searchRouteViewModel.storyToShowIndex)
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
        
        if searchRouteViewModel.storyToShowIndex == searchRouteViewModel.stories.count - 1 {
            closeStory()
            return
        }
        
        model.nextStory(
            currentStoryIndex: searchRouteViewModel.storyToShowIndex,
            storiesCount: searchRouteViewModel.stories.count
        )
    }
    
    private func closeStory() {
        withAnimation(.easeInOut(duration: 0.4)) {
            searchRouteViewModel.showStory = false
        }
    }
    
    private func didStoryShowed() {
        storiesManager.markAsShowed(story: searchRouteViewModel.stories[searchRouteViewModel.storyToShowIndex])
        
        if isLastStoryShowed() {
            closeStory()
        }
    }
    
    private func isLastStoryShowed() -> Bool {
        searchRouteViewModel.storyToShowIndex == searchRouteViewModel.stories.count - 1
        && model.currentProgress == 1.0
    }
}

#Preview {
    StoriesView()
        .environmentObject(SearchRouteViewModel())
        .environmentObject(StoriesManager())
}
