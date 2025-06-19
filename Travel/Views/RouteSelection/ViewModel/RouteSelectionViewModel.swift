import Foundation

@MainActor
final class RouteSelectionViewModel: ObservableObject {
    @Published var cardData: RouteCardData?

    func setup(data: RouteCardData) {
        self.cardData = data
    }
}
