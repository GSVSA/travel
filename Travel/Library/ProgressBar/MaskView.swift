import SwiftUI

struct ProgressMaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                maskFragmentView
            }
        }
    }

    private var maskFragmentView: some View {
        RoundedRectangle(cornerRadius: 3)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(.white)
            .frame(height: 6)
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }
}

#Preview("ProgressMaskView") {
    ProgressMaskView(numberOfSections: 4)
        .padding()
        .background(Color.text)
}
