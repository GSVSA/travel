import SwiftUI

struct FilterSectionHeader: View {
    var title: LocalizedStringResource

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .padding()
        }
    }
}
