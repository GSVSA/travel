import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var withTransfers: TransferOption?
    @Published var filters: Filters?
    
    var isFilterSelected: Bool {
        withTransfers != nil
    }
    
    func setup(filters: Filters) {
        self.filters = filters
        
        if let withTransfers = filters.withTransfers {
            self.withTransfers = withTransfers ? .yes : .no
        }
    }

    func applyFilters(_ filters: inout Filters) {
        filters.withTransfers = withTransfers == .yes
    }
}
