import SwiftUI

struct StationsListView: View {
    @EnvironmentObject private var searchRouteViewModel: SearchRouteViewModel
    @EnvironmentObject private var citySelectionViewModel: CitySelectionViewModel
    
    @StateObject private var viewModel = StationsListViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            if let error = viewModel.isError {
                NetworkErrorView(errorType: error)
            } else {
                stationList

                if viewModel.isLoading {
                    ProgressView()
                }
                
                if !viewModel.isLoading {
                    Text("Station not found")
                        .empty(isVisible: viewModel.searchResult.isEmpty)
                }
            }

        }
        .onAppear {
            viewModel.setStations(stationsList: citySelectionViewModel.selectedCity.stations)
        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $searchRouteViewModel.isStationPresented)
        .modifier(.iOS18PlusBugFix)
    }
    
    private var stationList: some View {
        List(viewModel.searchResult, id: \.self) { station in
            HStack {
                Button(action: { selectStation(station, from: citySelectionViewModel.selectedCity) } ) {
                    Text("\(station.description?.description ?? "") \(station.name)".trimmingCharacters(in: .whitespaces))
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

    func selectStation(_ station: Station, from: CityData) {
        viewModel
            .selectStation(
                station: station,
                from: citySelectionViewModel.selectedCity,
                withStationData: &searchRouteViewModel.selectedStation
            )
        searchRouteViewModel.isStationPresented = false
    }
}

#Preview {
    let citySelectionViewModel = CitySelectionViewModel()
    NavigationStack {
        citySelectionViewModel.selectedCity = CityData(
            id: "s9623131",
            name: "Тула",
            stations: [
                Station(
                    id: "s9600839",
                    name: "Тула (Ряжский вокзал)",
                    description: .train
                ),
                Station(
                    id: "s9623131",
                    name: "Тула (Московский вокзал)",
                    description: .train
                )
            ]
        )
        return StationsListView()
            .environmentObject(SearchRouteViewModel())
            .environmentObject(citySelectionViewModel)
    }
}
