import SwiftUI

struct RadioButtonToggleStyle: ToggleStyle {
    func makeBody(
        configuration: Configuration
    ) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn
                  ? "record.circle"
                  : "circle"
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
    FiltersView()
        .environmentObject(RouteSelectionListViewModel())
}
