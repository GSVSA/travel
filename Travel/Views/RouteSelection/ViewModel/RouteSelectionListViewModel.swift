import Foundation

@MainActor
final class RouteSelectionListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isError: NetworkErrorType?
    @Published var allRoutes: [RouteCardData] = []
    
    @Published var filters: Filters = Filters()
    @Published var isFiltersPagePresented: Bool = false
    
    @Published var isCarrierPagePresented = false
    @Published var carrierForPresentation: CarrierModel?
    
    private let networkService = NetworkService()
    private let dateFormatter = DateFormatterService.shared
    private let carrierInfoDownloader = CarrierInfoDownloader()
    
    func openFiltersPage() {
        isFiltersPagePresented.toggle()
    }
    
    func presentCarrier(with carrier: CarrierModel) {
        isCarrierPagePresented = true
        carrierForPresentation = carrier
    }
    
    func getPageTitleFor(routes: RouteData) -> String {
        (routes.fromStation.station?.name ?? "") + " → " + (routes.toStation.station?.name ?? "")
    }
    
    func fetchRoutesAlong(way routes: RouteData) async {
        await MainActor.run {
            isLoading = true
            isError = nil
        }
        
        guard
            let fromStationId = routes.fromStation.station?.id,
            let toStationId = routes.toStation.station?.id
        else {
            await MainActor.run { setError(errorType: .serverError) }
            return
        }
        
        let routeSegments: RouteSegments
        do {
            routeSegments = try await getRouteSegments(
                fromStationId: fromStationId,
                toStationId: toStationId
            )
        }
        catch {
            await MainActor.run { setError(errorType: .noInternetConnection) }
            return
        }
        
        let routes: [RouteCardData] = await populateRoutesData(routeSegments: routeSegments)
        
        if isError != nil {
            return
        }
        
        await MainActor.run { [routes] in
            allRoutes = routes
            allRoutes.sort{ $0.departureDate < $1.departureDate }
            allRoutes = applyFilters(routes: allRoutes)
            
            isLoading = false
            isError = nil
        }
    }
    
    private func applyFilters(routes: [RouteCardData]) -> [RouteCardData] {
        let filteredSegments = routes.filter { route in
            if route.hasTransfers && !(filters.withTransfers ?? true) {
                return false
            }
            
            var isTimeSelected = false
            for time in filters.departureTime where time.isSelected {
                isTimeSelected = true
                break
            }
            if !isTimeSelected {
                return true
            }

            switch route.departureHour {
            case 6...11 where filters.departureTime.first(where: { $0.time == .morning })?.isSelected == true:
                return true
            case 12...17 where filters.departureTime.first(where: { $0.time == .afternoon })?.isSelected == true:
                return true
            case 18..<24 where filters.departureTime.first(where: { $0.time == .evening })?.isSelected == true:
                return true
            case 0...5 where filters.departureTime.first(where: { $0.time == .night })?.isSelected == true:
                return true
            default:
                return false
            }
        }
        return filteredSegments
    }
    
    private func populateRoutesData(routeSegments: RouteSegments) async -> [RouteCardData] {
        var routes: [RouteCardData] = []
        
        for segment in routeSegments {
            guard
                let departureDate: Date = dateFormatter.formatISOStringToDate(segment.departure),
                let arrivalDate: Date = dateFormatter.formatISOStringToDate(segment.arrival)
            else {
                setError(errorType: .serverError)
                return routes
            }
            
            let hasTransfers = segment.has_transfers ?? false
            var transferTitle: String = ""
            
            if hasTransfers == true, let transfers = segment.transfers {
                transferTitle = transfers
                    .compactMap { $0.title }
                    .joined(separator: ", ")
            }
            
            var carrierId: Int = segment.thread?.carrier?.code ?? 0
            
            if carrierId == 0 {
                segment.details?.forEach { detail in
                    if let thread = detail.value1?.thread, let carrierCode = thread.carrier?.code {
                        carrierId = carrierCode
                    }
                }
            }
            
            var carrier: CarrierModel = CarrierModel(
                code: carrierId,
                title: segment.thread?.carrier?.title ?? "",
                phone: segment.thread?.carrier?.phone ?? "",
                logo: segment.thread?.carrier?.logo ?? "",
                email: segment.thread?.carrier?.email ?? ""
            )

            if
                carrier.logo.isEmpty,
                carrier.email.isEmpty,
                carrierId != 0
            {
                let carrierInfo: Carrier?
                do {
                    carrierInfo = try await carrierInfoDownloader.downloadCarrierFor(carrierCode: carrierId)
                }
                catch {
                    await MainActor.run { setError(errorType: .noInternetConnection) }
                    return routes
                }

                if let carrierInfo {
                    carrier = CarrierModel(
                        code: carrierInfo.carrier?.code ?? carrier.code,
                        title: carrierInfo.carrier?.title ?? carrier.title,
                        phone: carrierInfo.carrier?.phone ?? "",
                        logo: carrierInfo.carrier?.logo ?? "",
                        email: carrierInfo.carrier?.email ?? ""
                    )
                }
            }
                
            routes.append(
                RouteCardData(
                    departureDate: departureDate,
                    arrivalDate: arrivalDate,
                    hasTransfers: hasTransfers,
                    transferTitle: transferTitle,
                    carrier: carrier
                )
            )
        }
        
        return routes
    }
    
    private func getRouteSegments(
        fromStationId: String,
        toStationId: String
    ) async throws -> RouteSegments {
        let dates: [String] = generateRouteDates()
        
        return try await withThrowingTaskGroup(
            of: SearchResponse.self,
            returning: RouteSegments.self
        ) { group in
            for date in dates {
                group.addTask {
                    try await self.networkService
                        .searchRoutes(
                            from: fromStationId,
                            to: toStationId,
                            date: date,
                            hasTransfers: true
                        )
                }
            }
            
            var segments: RouteSegments = []
            for try await result in group {
                guard let responseSegments = result.segments else { continue }
                segments.append(contentsOf: responseSegments)
            }
            return segments
        }
    }
    
    private func generateRouteDates() -> [String] {
        var dates: [String] = []
        let dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let calendar = Calendar.current
        
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: currentDate) {
                let dateString = dateFormatter.stringFromDate(date, inFormat: dateFormat)
                dates.append(dateString)
            }
        }
        
        return dates
    }
    
    private func setError(errorType: NetworkErrorType) {
        isLoading = false
        isError = errorType
    }
}
