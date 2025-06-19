import SwiftUI

struct UserAgreementView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel

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
                        WebViewBridge(url: "https://yandex.ru/legal/practicum_offer/")
                            .environmentObject(model)
                        
                        if model.isLoading {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("User agreement")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .backButtonToolbarItem(isShowRoot: $settingsViewModel.isUserAgreementPresented)
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
            .environmentObject(SettingsViewModel())
            .environmentObject(UserAgreementViewModel())
    }
}
