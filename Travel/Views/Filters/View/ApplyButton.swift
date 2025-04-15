import SwiftUI

struct ApplyButton: View {
    var action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                Text("Apply")
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60
                    )
                    .font(.system(size: 17, weight: .bold))
            }
        )
        .background(Color.accent)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
