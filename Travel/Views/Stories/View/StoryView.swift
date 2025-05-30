import SwiftUI

struct StoryView: View {
    let story: StoryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text(story.title)
                    .font(.system(size: 34, weight: .bold))
                    .lineLimit(1)
                    .padding(.bottom, 16)
                Text(story.description)
                    .font(.system(size: 20))
                    .lineLimit(3)
            }
            .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
        .background(
            StoryBackgroundView(image: story.backgroundImage)
        )
    }
}

#Preview {
    if let story = SearchRouteViewModel().stories.last {
        StoryView(story: story)
    }
}
