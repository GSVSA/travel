import SwiftUI

struct StoryPreviewView: View {
    let story: StoryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(story.title)
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 12)
        .frame(
            minWidth: 92,
            maxWidth: 92,
            minHeight: 140,
            maxHeight: 140
        )
        .background(
            StoryBackgroundView(image: story.backgroundImage)
        )
    }
}

#Preview {
    if let story = SearchRouteViewModel().stories.last {
        StoryPreviewView(story: story)
    }
}
