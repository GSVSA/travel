import SwiftUI

struct CarrierProperty: View {
    var title: String
    var value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 17))
            Text(value)
                .font(.system(size: 12))
                .foregroundStyle(Color.accent)
        }
        .frame(height: 60)
    }
}
