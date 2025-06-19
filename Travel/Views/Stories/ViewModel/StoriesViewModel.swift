import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published var currentProgress: CGFloat = 0
    @Published var timerConfiguration: TimerConfiguration?
    
    private var indexKeeper: Int = 0
    
    func setupTimerConfiguration(storiesCount: Int) {
        timerConfiguration = TimerConfiguration(storiesCount: storiesCount)
    }
    
    func saveStoryIndex(currentValue: Int, newValue: Int) {
        didChangeCurrentIndex(oldIndex: indexKeeper, newIndex: newValue)
        
        guard indexKeeper != currentValue else { return }
        indexKeeper = newValue
    }
    
    func didChangeCurrentProgress(newProgress: CGFloat, currentStoryIndex: inout Int) {
        guard let timerConfiguration else { return }
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        currentStoryIndex = index
    }
    
    func nextStory(currentStoryIndex: Int, storiesCount: Int) {
        indexKeeper = (currentStoryIndex + 1) % storiesCount
        didChangeCurrentIndex(oldIndex: currentStoryIndex, newIndex: indexKeeper)
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard let timerConfiguration, oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        currentProgress = progress
    }
}
