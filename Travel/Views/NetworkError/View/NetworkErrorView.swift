import SwiftUI

struct NetworkErrorView: View {
    var errorType: NetworkErrorType

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                Image(errorType.model.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 223,
                        height: 223,
                        alignment: .center
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 70))

                Text(errorType.model.description)
                    .empty()
            }
        }
    }
}

#Preview("Server error") {
    NetworkErrorView(errorType: .serverError)
}

#Preview("No Internet") {
    NetworkErrorView(errorType: .noInternetConnection)
}
