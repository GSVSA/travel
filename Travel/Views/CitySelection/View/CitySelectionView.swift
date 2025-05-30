import SwiftUI

struct CitySelectionView: View {
    @Binding var stationData: StationData
    @Binding var isShowRoot: Bool

    @StateObject private var viewModel = CitySelectionViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoadingError {
                NetworkErrorView(errorType: .noInternetConnection)
            } else {
                cityList
                
                Text("City not found")
                    .empty(isVisible: viewModel.searchResult.isEmpty)
            }
        }
        .navigationDestination(isPresented: $viewModel.isCitySelected) {
            StationsListView(
                stationData: $stationData,
                city: $viewModel.selectedCity,
                isShowRoot: $isShowRoot
            )
        }
        .navigationTitle("City selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }
    
    private var cityList: some View {
        List(viewModel.searchResult, id: \.self) { city in
            HStack {
                Button(action: { viewModel.selectCity(city) } ) {
                    Text(city)
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
        CitySelectionView(
            stationData: .constant(StationData(stationType: .from)),
            isShowRoot: .constant(true)
        )
    }
}
