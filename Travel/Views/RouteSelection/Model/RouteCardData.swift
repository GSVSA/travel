import Foundation

struct RouteCardData: Identifiable, Hashable {
    let id = UUID()
    let carrier: CarrierModel

    private let departureDate: Date
    private let arrivalDate: Date
    private let hasTransfers: Bool
    private let transferTitle: String?
    private var dateFormatter = DateFormatter()

    var duration: Int {
        let delta = departureDate.distance(to: arrivalDate)
        let hours = Int(delta) / 3600
        return hours
    }

    var departureDay: String {
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: departureDate)
    }

    var departureTime: String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: departureDate)
    }

    var departureHour: Int {
        Calendar.current.component(.hour, from: departureDate)
    }

    var arrivalTime: String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: arrivalDate)
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
