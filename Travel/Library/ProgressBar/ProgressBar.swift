import SwiftUI

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: geometry.size.width, height: 6)
                    .foregroundColor(.background)
                
                RoundedRectangle(cornerRadius: 3)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: 6
                    )
                    .foregroundColor(.accent)
            }
            .mask {
                ProgressMaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

#Preview {
    ProgressBar(numberOfSections: 5, progress: 0.5)
        .padding()
        .background(
            Image(.story1)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
}
