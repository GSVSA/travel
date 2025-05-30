import SwiftUI

struct StationsListView: View {
    @Binding var stationData: StationData
    @Binding var city: String
    @Binding var isShowRoot: Bool
    
    @StateObject private var viewModel = StationsListViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoadingError {
                NetworkErrorView(errorType: .noInternetConnection)
            } else {
                stationList
                
                Text("Station not found")
                    .empty(isVisible: viewModel.searchResult.isEmpty)
            }

        }
        .navigationTitle("Station selection")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }
    
    private var stationList: some View {
        List(viewModel.searchResult, id: \.self) { station in
            HStack {
                Button(action: { selectStation(station, from: city) } ) {
                    Text(station)
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

    func selectStation(_ station: String, from: String) {
        viewModel.selectStation(station: station, from: city, withStationData: &stationData)
        isShowRoot = false
    }
}

#Preview {
    NavigationStack {
        StationsListView(
            stationData: .constant(StationData(stationType: .from)),
            city: .constant(""),
            isShowRoot: .constant(true)
        )
    }
}
