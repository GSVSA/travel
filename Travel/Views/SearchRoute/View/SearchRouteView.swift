import SwiftUI

struct SearchRouteView: View {
    @StateObject private var viewModel = SearchRouteViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.accent)
                        .frame(
                            idealWidth: 343,
                            maxHeight: 128
                        )
                        .padding(.horizontal)

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
                        .padding(.top)
                        .padding(.leading)
                        .frame(
                            idealWidth: 343,
                            maxHeight: 128
                        )

                        Button(action: viewModel.changeStations) {
                            Image(systemName: "arrow.2.squarepath")
                        }
                        .frame(
                            width: 36,
                            height: 36
                        )
                        .background(.white)
                        .accentColor(Color.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)

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
                .opacity(viewModel.fromStation.description.isEmpty || viewModel.toStation.description.isEmpty ? 0 : 1)

                Spacer()
            }
            .opacity(viewModel.isLoadingError ? 0 : 1)
            
            VStack {
                NetworkErrorView(errorType: .noInternetConnection)
                    .opacity(viewModel.isLoadingError ? 1 : 0)
                Divider()
            }
        }
        .navigationDestination(isPresented: $viewModel.isFromStationPresented) {
            CitySelectionView(
                stationData: $viewModel.fromStation,
                isShowRoot: $viewModel.isFromStationPresented
            )
        }
        .navigationDestination(isPresented: $viewModel.isToStationPresented) {
            CitySelectionView(
                stationData: $viewModel.toStation,
                isShowRoot: $viewModel.isToStationPresented
            )
        }
        .navigationDestination(isPresented: $viewModel.isFindRoutesPresented) {
            RouteSelectionListView(isShowRoot: $viewModel.isFindRoutesPresented)
        }
    }
}

#Preview {
    NavigationStack {
        SearchRouteView()
    }
}
