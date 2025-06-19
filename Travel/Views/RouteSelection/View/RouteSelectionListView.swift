import SwiftUI

private enum Constants {
    static let filterButtonCircleSize: CGFloat = 8
}

struct RouteSelectionListView: View {
    @EnvironmentObject var searchRouteViewModel: SearchRouteViewModel
    
    @StateObject private var viewModel = RouteSelectionListViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                if let error = viewModel.isError {
                    NetworkErrorView(errorType: error)
                } else {
                    VStack {
                        pageTitle
                        routeList
                            .safeAreaInset(edge: .bottom) {
                                filterButton
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    if !viewModel.isLoading {
                        Text("There are no options")
                            .empty(isVisible: viewModel.allRoutes.isEmpty)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isFiltersPagePresented) {
                FiltersView()
                    .environmentObject(viewModel)
            }
        }
        .task {
            await viewModel.fetchRoutesAlong(way: searchRouteViewModel.getRouteCardData())
        }
        .navigationDestination(isPresented: $viewModel.isCarrierPagePresented) {
            CarrierInfoView()
                .environmentObject(viewModel)
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $searchRouteViewModel.isFindRoutesPresented)
    }
    
    private var pageTitle: some View {
        Text(verbatim: viewModel.getPageTitleFor(routes: searchRouteViewModel.getRouteCardData()))
            .font(.system(size: 24, weight: .bold))
            .padding(.horizontal)
            .padding(.top)
    }
    
    private var routeList: some View {
        List(viewModel.allRoutes) { routeCard in
            RouteSelectionView(routeCardData: routeCard)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(.init(.zero))
                .onTapGesture {
                    viewModel.presentCarrier(with: routeCard.carrier)
                }
        }
        .listStyle(.plain)
    }
    
    private var filterButton: some View {
        Button(action: viewModel.openFiltersPage) {
            HStack {
                Text("Specify time")
                Circle()
                    .fill(Color.danger)
                    .frame(
                        minWidth: Constants.filterButtonCircleSize,
                        idealWidth: Constants.filterButtonCircleSize,
                        maxHeight: Constants.filterButtonCircleSize
                    )
                    .opacity(viewModel.filters.isSelected ? 1 : 0)
            }
            .frame(
                maxWidth: .infinity,
                minHeight: 60
            )
            .font(.system(size: 17, weight: .bold))
        }
        .background(Color.accent)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

#Preview {
    let searchRouteViewModel = SearchRouteViewModel()
    searchRouteViewModel.fromStation = StationData(
        stationType: .from,
        city: "Москва",
        station: Station(
            id: "s2000005",
            name: "Москва (Павелецкий вокзал)",
            description: .train
        )
    )
    searchRouteViewModel.toStation = StationData(
        stationType: .to,
        city: "Тула",
        station: Station(
            id: "s9623131",
            name: "Тула (Московский вокзал)",
            description: .train
        )
    )
    return RouteSelectionListView()
        .environmentObject(RouteSelectionListViewModel())
        .environmentObject(searchRouteViewModel)
}
