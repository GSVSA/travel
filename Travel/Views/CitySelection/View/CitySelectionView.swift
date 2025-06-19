import SwiftUI

struct CitySelectionView: View {
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel

    @StateObject private var viewModel = CitySelectionViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            if let error = viewModel.isError {
                NetworkErrorView(errorType: error)
            } else {
                cityList
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if !viewModel.isLoading {
                    Text("City not found")
                        .empty(isVisible: viewModel.searchResult.isEmpty)
                }
                
            }
        }
        .task {
            await viewModel.fetchCities()
        }
        .navigationDestination(isPresented: $viewModel.isCitySelected) {
            StationsListView()
                .environmentObject(viewModel)
                .environmentObject(searchRouteViewModel)
        }
        .navigationTitle("City selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $searchRouteViewModel.isStationPresented)
        .modifier(.iOS18PlusBugFix)
    }
    
    private var cityList: some View {
        List(viewModel.searchResult, id: \.self) { city in
            HStack {
                Button(action: { viewModel.selectCity(city) } ) {
                    Text(city.name)
                        .font(.system(size: 17))
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .listRowSeparator(.hidden)
            .padding(.init(top: 18, leading: 0, bottom: 18, trailing: 0))
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Enter your query"
        )
    }
}

#Preview {
    NavigationStack {
        CitySelectionView()
            .environmentObject(SearchRouteViewModel())
    }
}
