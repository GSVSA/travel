import SwiftUI

struct SearchRouteView: View {
    @StateObject private var viewModel = SearchRouteViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoadingError {
                VStack {
                    NetworkErrorView(errorType: .noInternetConnection)
                    Divider()
                }
            } else {
                VStack(spacing: 20) {
                    StoriesListView()
                        .environmentObject(viewModel)
                        .padding(.leading)
                    
                    ZStack {
                        selectStationViewBackgroundView
                        selectStationView
                    }
                    .padding(.top, 20)

                    if viewModel.isStationsSelected() {
                        findButton
                    }

                    Spacer()
                    Divider()
                }
            }
        }
        .overlay{
            if viewModel.showStory {
                StoriesView()
                    .environmentObject(viewModel)
            }
        }
        .navigationDestination(isPresented: $viewModel.isStationPresented) {
            CitySelectionView()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $viewModel.isFindRoutesPresented) {
            RouteSelectionListView()
                .environmentObject(viewModel)
        }
    }
    
    private var selectStationViewBackgroundView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.accent)
            .frame(
                idealWidth: 343,
                maxHeight: 128
            )
            .padding(.horizontal)
    }
    
    private var selectStationView: some View {
        HStack(spacing: 0) {
            VStack{
                List {
                    Section {
                        StationField(
                            stationData: viewModel.fromStation,
                            didSelect: viewModel.selectFromStation
                        )
                        StationField(
                            stationData: viewModel.toStation,
                            didSelect: viewModel.selectToStation
                        )
                        .padding(.bottom)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Rectangle().fill(.white))
                }
                .listStyle(.inset)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.bottom)
            }
            .padding([.top, .leading])
            .frame(
                idealWidth: 343,
                maxHeight: 128
            )

            changeStationsButton
        }
        .padding(.horizontal)
    }
    
    private var changeStationsButton: some View {
        Button(action: viewModel.changeStations) {
            Image(systemName: "arrow.2.squarepath")
        }
        .frame(
            width: 36,
            height: 36
        )
        .background(.white)
        .tint(Color.accent)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .padding(.horizontal)
    }
    
    private var findButton: some View {
        Button(action: viewModel.findRoutes) {
            Text("Find")
                .frame(
                    minWidth: 150,
                    minHeight: 60
                )
                .font(.system(size: 17, weight: .bold))
        }
        .background(Color.accent)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        SearchRouteView()
            .environmentObject(StoriesManager())
    }
}
