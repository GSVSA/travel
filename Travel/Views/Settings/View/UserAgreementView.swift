import SwiftUI

struct UserAgreementView: View {
    @Binding var isShowRoot: Bool

    @StateObject private var model: UserAgreementViewModel = UserAgreementViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ProgressView(value: model.loadingProgress)
                    .progressViewStyle(.linear)
                    .opacity(model.loadingProgress == 1.0 ? 0 : 1)
                ZStack {
                    if model.isLoadingError {
                        NetworkErrorView(errorType: .noInternetConnection)
                    } else {
                        WebViewBridge(
                            url: "https://yandex.ru/legal/practicum_offer/",
                            isLoading: $model.isLoading,
                            isLoadingError: $model.isLoadingError,
                            progress: $model.loadingProgress
                        )
                        
                        if model.isLoading {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("User agreement")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .backButtonToolbarItem(isShowRoot: $isShowRoot)
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
            .onAppear {
                model.isLoading = true
                model.loadingProgress = 0.0
                model.isLoadingError = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView(isShowRoot: .constant(false))
    }
}
