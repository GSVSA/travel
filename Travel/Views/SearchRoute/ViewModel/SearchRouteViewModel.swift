import Foundation

final class SearchRouteViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    
    @Published var fromStation: StationData = StationData(stationType: .from)
    @Published var toStation: StationData = StationData(stationType: .to)
    @Published var isFromStationPresented: Bool = false
    @Published var isToStationPresented: Bool = false
    
    @Published var isFindRoutesPresented: Bool = false
    
    @Published var storyToShowIndex: Int = 0
    @Published var showStory: Bool = false
    
    @Published var stories: [StoryModel] = {
        return Array(0...5).map { value in
            return StoryModel(
                id: value,
                backgroundImage: "Story_\(value + 1)",
                title: "🔥🔥🔥",
                description: Array(repeating: "Story description", count: 20).joined(separator: " ")
            )
        }
    }()
    
    func changeStations() {
        let from = fromStation
        let to = toStation
        
        fromStation = to
        toStation = from
    }
    
    func selectFromStation() {
        isFromStationPresented = true
    }
    
    func selectToStation() {
        isToStationPresented = true
    }
    
    func findRoutes() {
        isFindRoutesPresented = true
    }
    
    func isStationsSelected() -> Bool {
        guard let _ = fromStation.station, let _ = toStation.station else { return false }
        return true
    }
}
