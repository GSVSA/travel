import SwiftUI

private enum Constants {
    static let defaultRowHeight: CGFloat = 60
    static let optionsListHeight: CGFloat = defaultRowHeight * 4
}

struct FiltersView: View {
    @Binding var isShowRoot: Bool

    @StateObject private var model: FiltersViewModel = FiltersViewModel()

    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    FilterSectionHeader(title: DayTime.title)

                    List(DayTime.allCases) { param in
                        VStack {
                            Toggle(isOn: $model.isChecked) {
                                Text(param.description)
                                    .font(.system(size: 17))
                            }
                            .toggleStyle(.checkmark)
                        }
                        .frame(height: Constants.defaultRowHeight)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .frame(height: Constants.optionsListHeight)
                    .padding(.horizontal)
                }

                VStack(alignment: .leading) {
                    FilterSectionHeader(title: TransferOption.title)

                    List(TransferOption.allCases) { param in
                        VStack {
                            Toggle(isOn: $model.isChecked) {
                                Text(param.description)
                                    .font(.system(size: 17))
                            }
                            .toggleStyle(.radioButton)
                        }
                        .frame(height: Constants.defaultRowHeight)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .frame(height: Constants.optionsListHeight)
                    .padding(.horizontal)
                }
                .safeAreaInset(edge: .bottom) {
                    ApplyButton(action: didFilterApply)
                        .opacity(model.isChecked ? 1 : 0)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .backButtonToolbarItem(isShowRoot: $isShowRoot)
    }

    private func didFilterApply() {
        isShowRoot.toggle()
    }
}

#Preview {
    FiltersView(isShowRoot: .constant(true))
}
