import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.4)) {
                action()
            }
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
        }
        .tint(.text)
        .background(Color.background)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: 30, height: 30)
    }
}

#Preview {
    CloseButton(action: {})
}
