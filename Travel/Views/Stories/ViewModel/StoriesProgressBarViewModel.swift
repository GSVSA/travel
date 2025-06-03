import Foundation
import Combine

final class StoriesProgressBarViewModel: ObservableObject {
    @Published var timer: Timer.TimerPublisher
    
    private var timerConfiguration: TimerConfiguration
    private var cancellable: Cancellable?
    
    init(timerConfiguration configuration: TimerConfiguration) {
        timerConfiguration = configuration
        timer = Self.createTimer(configuration: timerConfiguration)
    }

    func startTimer() {
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
        timerConfiguration.nextProgress(progress: progress)
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}
