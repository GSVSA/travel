import Foundation
import Combine

@MainActor
final class StoriesProgressBarViewModel: ObservableObject {
    @Published var timer = Timer.publish(every: 0, on: .main, in: .common)
    
    private var timerConfiguration: TimerConfiguration?
    private var cancellable: Cancellable?
    
    func setupTimer(timerConfiguration configuration: TimerConfiguration?) {
        guard let configuration else { return }
        timerConfiguration = configuration
        timer = Self.createTimer(configuration: configuration)
    }

    func startTimer() {
        guard let timerConfiguration else { return }
        timer = Self.createTimer(configuration: timerConfiguration)
        cancellable = timer.connect()
    }

    func stopTimer() {
        cancellable?.cancel()
    }

    func resetTimer() {
        stopTimer()
        startTimer()
    }

    func timerTick(progress: CGFloat) -> CGFloat {
        timerConfiguration?.nextProgress(progress: progress) ?? 0
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
