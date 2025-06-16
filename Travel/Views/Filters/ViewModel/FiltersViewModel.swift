import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var withTransfers: TransferOption? = nil
    @Published var filters: Filters?
    
    var isFilterSelected: Bool {
        withTransfers != nil
    }
    
    func setup(filters: Filters) {
        self.filters = filters
        
        if let withTransfers = filters.withTransfers {
            self.withTransfers = withTransfers == true ? .yes : .no
        }
    }

    func applyFilters(_ filters: inout Filters) {
        filters.withTransfers = withTransfers == .yes
    }
}
