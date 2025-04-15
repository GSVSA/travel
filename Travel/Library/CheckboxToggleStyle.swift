import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn
                  ? "checkmark.square.fill"
                  : "square"
            )
            .resizable()
            .frame(width: 24, height: 24)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
}

#Preview {
    FiltersView(isShowRoot: .constant(true))
}
