import SwiftUI

private enum Constants {
    static let defaultRowHeight: CGFloat = 60
    static let optionsListHeight: CGFloat = defaultRowHeight * 4
}

struct FiltersView: View {
    @EnvironmentObject private var routeSelectionListViewModel: RouteSelectionListViewModel

    @StateObject private var model = FiltersViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                departureTimeView
                transfersView
                    .safeAreaInset(edge: .bottom) {
                        ApplyButton(action: didFilterApply)
                            .opacity(model.isFilterSelected ? 1 : 0)
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $routeSelectionListViewModel.isFiltersPagePresented)
        .onAppear {
            model.setup(filters: routeSelectionListViewModel.filters)
        }
    }
    
    private var departureTimeView: some View {
        VStack(alignment: .leading) {
            FilterSectionHeader(title: DayTime.title)
            
            List(routeSelectionListViewModel.filters.departureTime.indices) { index in
                VStack {
                    Toggle(isOn: $routeSelectionListViewModel.filters.departureTime[index].isSelected) {
                        Text(routeSelectionListViewModel.filters.departureTime[index].time.description)
                            .font(.system(size: 17))
                    }
                    .toggleStyle(.checkmark)
                }
                .frame(height: Constants.defaultRowHeight)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .frame(height: Constants.optionsListHeight)
            .padding(.horizontal)
        }
    }
    
    private var transfersView: some View {
        VStack(alignment: .leading) {
            FilterSectionHeader(title: TransferOption.title)
            
            List(TransferOption.allCases) { option in
                VStack {
                    Toggle(isOn: transfersToggle(option: option)) {
                        Text(option.description)
                            .font(.system(size: 17))
                    }
                    .toggleStyle(.radioButton)
                }
                .frame(height: Constants.defaultRowHeight)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .frame(height: Constants.optionsListHeight)
            .padding(.horizontal)
        }
    }

    private func didFilterApply() {
        model.applyFilters(&routeSelectionListViewModel.filters)
        routeSelectionListViewModel.isFiltersPagePresented.toggle()
    }
    
    private func transfersToggle(
        option: TransferOption
    ) -> Binding<Bool> {
        Binding(
            get: { model.withTransfers == option },
            set: { newValue in
                model.withTransfers = newValue ? option : nil
            }
        )
    }
}

#Preview {
    FiltersView()
        .environmentObject(RouteSelectionListViewModel())
}
