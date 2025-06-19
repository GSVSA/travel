import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    @Published var isLoadingError = false
    
    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
}
