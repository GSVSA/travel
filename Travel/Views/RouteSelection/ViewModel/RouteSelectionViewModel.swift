import Foundation

final class RouteSelectionViewModel: ObservableObject {
    @Published var cardData: RouteCardData?
    @Published var isCarrierPagePresented: Bool = false

    func setup(data: RouteCardData) {
        self.cardData = data
    }
}
