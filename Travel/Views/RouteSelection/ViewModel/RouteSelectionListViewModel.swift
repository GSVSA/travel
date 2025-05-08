import Foundation

final class RouteSelectionListViewModel: ObservableObject {
    @Published var isFiltersPagePresented: Bool = false
    @Published var isLoadingError: Bool = false
    
    func openFiltersPage() {
        isFiltersPagePresented.toggle()
    }
}
