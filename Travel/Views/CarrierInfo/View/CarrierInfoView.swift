import SwiftUI

struct CarrierInfoView: View {
    @Binding var isShowRoot: Bool
    
    var carrier: CarrierModel

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: carrier.logo)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(idealHeight: 104)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 16))

                HStack {
                    Text(carrier.title)
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }

                List {
                    Group {
                        CarrierProperty(
                            title: "E-mail",
                            value: carrier.email
                        )
                        CarrierProperty(
                            title: "Phone",
                            value: carrier.phone
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
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }
}

let mockCarrier = CarrierModel(
    title: "Turkish Airlines",
    phone: "+7 (800) 555-35-35",
    logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
    email: "example@mail.com"
)

#Preview {
    NavigationStack {
        CarrierInfoView(isShowRoot: .constant(true), carrier: mockCarrier)
    }
}
