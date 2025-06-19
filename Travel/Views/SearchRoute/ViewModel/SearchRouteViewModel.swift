import Foundation

@MainActor
final class SearchRouteViewModel: ObservableObject {
    @Published var isLoadingError: Bool = false
    
    @Published var fromStation: StationData = StationData(stationType: .from)
    @Published var toStation: StationData = StationData(stationType: .to)
    
    @Published var selectedStation: StationData? = nil {
        didSet {
            guard let selectedStation, let _ = selectedStation.station?.name else { return }
            if
                selectedStation.stationType == .from {
                fromStation = selectedStation
            } else {
                toStation = selectedStation
            }
        }
    }
    
    @Published var isStationPresented: Bool = false
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
        isStationPresented = true
        selectedStation = fromStation
    }
    
    func selectToStation() {
        isStationPresented = true
        selectedStation = toStation
    }
    
    func findRoutes() {
        guard isStationsSelected() else { return }
        isFindRoutesPresented = true
    }
    
    func isStationsSelected() -> Bool {
        guard let _ = fromStation.station, let _ = toStation.station else { return false }
        return true
    }
    
    func getRouteCardData() -> RouteData {
        RouteData(
            fromStation: fromStation,
            toStation: toStation
        )
    }
}
