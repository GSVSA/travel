import SwiftUI
import Combine

struct StoriesProgressBarView: View {
    let storiesCount: Int
    let timerConfiguration: TimerConfiguration
    @Binding var currentProgress: CGFloat

    @StateObject private var model: StoriesProgressBarViewModel

    init(storiesCount: Int, timerConfiguration: TimerConfiguration, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self._model = StateObject(wrappedValue: StoriesProgressBarViewModel(timerConfiguration: timerConfiguration))
    }

    var body: some View {
        ProgressBar(
            numberOfSections: storiesCount,
            progress: currentProgress
        )
        .padding(.top, 20)
        .padding(.horizontal, 12)
        .onAppear {
            model.startTimer()
        }
        .onDisappear {
            model.stopTimer()
        }
        .onReceive(model.timer) { _ in
            timerTick()
        }
    }
    
    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
}

#Preview {
    let storiesCount = 3

    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView(
            storiesCount: storiesCount,
            timerConfiguration: TimerConfiguration(storiesCount: storiesCount),
            currentProgress: .constant(0.5)
        )
    }
}
