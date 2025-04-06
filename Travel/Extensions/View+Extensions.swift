import SwiftUI

extension View {
    func backButtonToolbarItem(isShowRoot: Binding<Bool>) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { isShowRoot.wrappedValue.toggle() }) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .accentColor(.text)
                }
            }
        }
    }
}
