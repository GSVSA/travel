import SwiftUI

private enum Constants {
    static let carrierLogoSize: CGFloat = 38
}

struct RouteSelectionView: View {
    @StateObject private var viewModel = RouteSelectionViewModel()
    var routeCardData: RouteCardData

    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 4) {
                Spacer()
                HStack {
                    carrierLogo
                    carrierAndTransferInfo
                    Spacer()
                    departureDay
                }

                schedule
            }
            .padding(.all, 14)
            .frame(maxHeight: 104)
            .background(Color.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: 24)
            )
        }
        .frame(idealHeight: 104)
        .foregroundStyle(Color.text)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .onAppear {
            viewModel.setup(data: routeCardData)
        }
    }
    
    private var carrierLogo: some View {
        AsyncImage(
            url: URL(string: viewModel.cardData?.carrier.logo ?? ""),
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                Image(systemName: "train.side.front.car")
            @unknown default:
                EmptyView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: Constants.carrierLogoSize, height: Constants.carrierLogoSize)
        .scaledToFit()
    }
    
    private var departureDay: some View {
        VStack(spacing: 0) {
            Text(viewModel.cardData?.departureDay ?? "")
                .font(.system(size: 12))
                .foregroundStyle(.black)
                .padding(.trailing, -7)
            Spacer()
        }
        .frame(height: Constants.carrierLogoSize)
    }
    
    private var carrierAndTransferInfo: some View {
        VStack(alignment: .leading) {
            Text(viewModel.cardData?.carrier.title ?? "")
                .font(.system(size: 17))
                .foregroundStyle(.black)
                .lineLimit(1)

            if let transferTitle = viewModel.cardData?.formattedTransferTitle {
                Text(transferTitle)
                    .foregroundStyle(Color.danger)
                    .font(.system(size: 12))
            }
        }
    }
    
    private var schedule: some View {
        HStack {
            Text(viewModel.cardData?.departureTime ?? "")
                .font(.system(size: 17))
                .foregroundStyle(.black)
            Rectangle()
                .fill(Color.gray)
                .frame(maxWidth: .infinity, maxHeight: 1)
            Text(viewModel.cardData?.arrivalTime ?? "")
                .font(.system(size: 17))
                .foregroundStyle(.black)
        }
        .frame(height: 48)
        .overlay(alignment: .center) {
            duration
        }
    }
    
    private var duration: some View {
        Text("\(viewModel.cardData?.duration ?? 0) hour")
            .font(.system(size: 12))
            .foregroundStyle(.black)
            .padding(.horizontal, 5)
            .background(Color.backgroundCard)
    }
}

#Preview {
    let mockData = RouteCardData(
        departureDate: Date(),
        arrivalDate: Date().addingTimeInterval(5 * 3600),
        hasTransfers: true,
        transferTitle: "Москва",
        carrier: CarrierModel(
            code: 1,
            title: "РЖД",
            phone: "+7 (800) 555-35-35",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
            email: "example@mail.com"
        )
    )
    RouteSelectionView(routeCardData: mockData)
}
