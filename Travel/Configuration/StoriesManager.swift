import SwiftUI

final class StoriesManager: ObservableObject {
    @AppStorage("storiesShowed") private var storiesShowed: Data = Data()
    
    func markAsShowed(story: StoryModel) {
        var storiesIdList: Set<String> = loadStoriesItems()
        storiesIdList.insert(story.id.description)
        saveStoriesItems(storiesIdList)
    }
    
    func isStoryShowed(story: StoryModel) -> Bool {
        let storiesIdList: Set<String> = loadStoriesItems()
        return storiesIdList.contains(story.id.description)
    }
    
    private func loadStoriesItems() -> Set<String> {
        guard
            let decodedArray = try? JSONDecoder().decode([String].self, from: storiesShowed)
        else {
            return []
        }
        return Set(decodedArray)
    }
    
    private func saveStoriesItems(_ storiesItem: Set<String>) {
        let itemsArray = Array(storiesItem)
        guard let encodedData = try? JSONEncoder().encode(itemsArray) else { return }
        storiesShowed = encodedData
    }
}
