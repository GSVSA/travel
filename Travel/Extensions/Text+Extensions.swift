import SwiftUI

extension Text {
    func empty(isVisible: Bool = true) -> some View {
        self
            .opacity(isVisible ? 1 : 0)
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    Text("Empty Text")
        .empty()
}
