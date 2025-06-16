import SwiftUI

struct CarrierInfoView: View {
    @EnvironmentObject var routeSelectionListViewModel: RouteSelectionListViewModel

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 16) {
                AsyncImage(
                    url: URL(string: routeSelectionListViewModel.carrierForPresentation?.logo ?? ""),
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Image(systemName: "train.side.front.car")
                                .resizable()
                                .scaledToFit()
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .transition(.scale(scale: 0.1, anchor: .center))
                    case .failure:
                        Image(systemName: "train.side.front.car")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 104)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack {
                    Text(routeSelectionListViewModel.carrierForPresentation?.title ?? "")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }

                List {
                    Group {
                        CarrierProperty(
                            title: "E-mail",
                            value: routeSelectionListViewModel.carrierForPresentation?.email ?? ""
                        )
                        CarrierProperty(
                            title: "Phone",
                            value: routeSelectionListViewModel.carrierForPresentation?.phone ?? ""
                        )
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationTitle("Carrier information")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $routeSelectionListViewModel.isCarrierPagePresented)
    }
}

#Preview {
    var model = RouteSelectionListViewModel()
    model.carrierForPresentation = CarrierModel(
        code: 1,
        title: "Turkish Airlines",
        phone: "+7 (800) 555-35-35",
        logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
        email: "example@mail.com"
    )
    return NavigationStack {
        CarrierInfoView()
            .environmentObject(model)
    }
}
