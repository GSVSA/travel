import SwiftUI


struct StoriesProgressBarView: View {
    @EnvironmentObject private var storiesViewModel: StoriesViewModel
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel
    
    @StateObject private var model: StoriesProgressBarViewModel = StoriesProgressBarViewModel()

    var body: some View {
        ProgressBar(
            numberOfSections: searchRouteViewModel.stories.count,
            progress: storiesViewModel.currentProgress
        )
        .padding(.top, 20)
        .padding(.horizontal, 12)
        .onAppear {
            model.setupTimer(timerConfiguration: storiesViewModel.timerConfiguration)
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
            guard let timerConfiguration = storiesViewModel.timerConfiguration else { return }
            storiesViewModel.currentProgress = timerConfiguration.nextProgress(progress: storiesViewModel.currentProgress)
        }
    }
}

#Preview {
    let storiesCount = 3
    
    ZStack {
        Color(.lightGray)
            .ignoresSafeArea()
        StoriesProgressBarView()
            .environmentObject(StoriesViewModel())
            .environmentObject(SearchRouteViewModel())
    }
}
