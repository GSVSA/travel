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
        .frame(width: 92, height: 140)
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
