import Foundation

struct RouteCardData: Identifiable, Hashable {
    let id = UUID()
    let departureDate: Date
    let arrivalDate: Date
    let hasTransfers: Bool
    let transferTitle: String?
    let carrier: CarrierModel
    
    private var dateFormatter = DateFormatterService.shared
    
    static func == (lhs: RouteCardData, rhs: RouteCardData) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var duration: Int {
        let delta = departureDate.distance(to: arrivalDate)
        let hours = Int(delta) / 3600
        return hours
    }

    var departureDay: String {
        dateFormatter.stringFromDate(departureDate, inFormat: "d MMMM")
    }

    var departureTime: String {
        dateFormatter.stringFromDate(departureDate, inFormat: "HH:mm")
    }

    var departureHour: Int {
        Calendar.current.component(.hour, from: departureDate)
    }

    var arrivalTime: String {
        dateFormatter.stringFromDate(arrivalDate, inFormat: "HH:mm")
    }

    var formattedTransferTitle: String? {
        if hasTransfers, let transferTitle {
            return String(localized: "With a transfer in") + " " + transferTitle
        } else {
            return nil
        }
    }

    init(
        departureDate: Date,
        arrivalDate: Date,
        hasTransfers: Bool,
        transferTitle: String? = nil,
        carrier: CarrierModel
    ) {
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.hasTransfers = hasTransfers
        self.transferTitle = transferTitle
        self.carrier = carrier
    }
}
