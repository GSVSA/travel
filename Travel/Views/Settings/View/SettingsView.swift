import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appSettings: AppSettings
    
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                List {
                    Section {
                        Toggle(
                            "Dark mode",
                            isOn: $viewModel.isDarkModeEnabled
                        )
                        .font(.system(size: 17))
                        .tint(Color.accent)
                        .padding(.bottom)
                        .onChange(of: viewModel.isDarkModeEnabled) { isEnabled in
                            viewModel.setDarkMode(isEnabled: isEnabled)
                        }

                        Text("User agreement")
                            .font(.system(size: 17))
                            .badge(
                                Text("\(Image(systemName: "chevron.right"))")
                            )
                            .onTapGesture {
                                viewModel.isUserAgreementPresented = true
                            }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .padding(.top)

                Spacer()

                VStack {
                    Text("The application uses the Yandex.Schedules API")
                        .font(.system(size: 12))
                    Text(viewModel.appVersion)
                        .font(.system(size: 12))
                        .padding()
                }

                Divider()
            }
        }
        .navigationDestination(isPresented: $viewModel.isUserAgreementPresented) {
            UserAgreementView()
                .environmentObject(viewModel)
        }
        .onAppear {
            self.viewModel.loadAppSetting(self.appSettings)
        }
    }
}

#Preview {
    NavigationStack {    
        SettingsView()
            .environmentObject(AppSettings())
    }
}
