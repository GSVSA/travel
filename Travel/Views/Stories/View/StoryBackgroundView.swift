import SwiftUI

struct StoryBackgroundView: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    if let story = SearchRouteViewModel().stories.last {
        StoryBackgroundView(image: story.backgroundImage)
    }
}
