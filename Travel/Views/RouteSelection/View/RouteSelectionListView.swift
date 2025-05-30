import SwiftUI

private enum Constants {
    static let filterButtonCircleSize: CGFloat = 8
}

struct RouteSelectionListView: View {
    @Binding var isShowRoot: Bool
    
    @StateObject private var viewModel = RouteSelectionListViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoadingError {
                    NetworkErrorView(errorType: .noInternetConnection)
                } else {
                    VStack {
                        pageTitle
                        routeList
                            .safeAreaInset(edge: .bottom) {
                                filterButton
                            }
                    }
                    
                    Text("There are no options")
                        .empty(isVisible: mockRouterData.isEmpty)
                }
            }
            .navigationDestination(isPresented: $viewModel.isFiltersPagePresented) {
                FiltersView(isShowRoot: $viewModel.isFiltersPagePresented)
            }
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }
    
    private var pageTitle: some View {
        Text(mockPageTitle)
            .font(.system(size: 24, weight: .bold))
            .padding(.horizontal)
            .padding(.top)
    }
    
    private var routeList: some View {
        List(mockRouterData, id: \.self) { routeCard in
            RouteSelectionView(routeCardData: routeCard)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(.init(.zero))
        }
        .listStyle(.plain)
    }
    
    private var filterButton: some View {
        Button(action: viewModel.openFiltersPage) {
            HStack(alignment: .center) {
                Text("Specify time")
                Circle()
                    .fill(Color.danger)
                    .frame(
                        minWidth: Constants.filterButtonCircleSize,
                        idealWidth: Constants.filterButtonCircleSize,
                        maxHeight: Constants.filterButtonCircleSize
                    )
                    .opacity(mockRouterData.isEmpty ? 1 : 0)
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
    NavigationStack {
        RouteSelectionListView(isShowRoot: .constant(false))
    }
}
