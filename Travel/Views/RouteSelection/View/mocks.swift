import Foundation

let mockPageTitle: String = "Москва (Белорусский вокзал) → Минск (Московский вокзал)"

let mockRouterData: [RouteCardData] = [
    RouteCardData(
        departureDate: Date().addingTimeInterval(3 * 3600),
        arrivalDate: Date().addingTimeInterval(5 * 3600),
        hasTransfers: false,
        transferTitle: nil,
        carrier: CarrierModel(
            title: "Метро Москвы",
            phone: "+7 (800) 555-35-35",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
            email: "example@mail.com"
        )
    ),
    RouteCardData(
        departureDate: Date().addingTimeInterval(3 * 3600),
        arrivalDate: Date().addingTimeInterval(6 * 3600),
        hasTransfers: false,
        transferTitle: nil,
        carrier: CarrierModel(
            title: "РЖД",
            phone: "+7 (800) 555-35-35",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
            email: "example@mail.com"
        )
    ),
    RouteCardData(
        departureDate: Date(),
        arrivalDate: Date().addingTimeInterval(5 * 3600),
        hasTransfers: true,
        transferTitle: "Кемеров",
        carrier: CarrierModel(
            title: "Вагонмейстер",
            phone: "+7 (800) 555-35-35",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
            email: "example@mail.com"
        )
    ),
    RouteCardData(
        departureDate: Date().addingTimeInterval(3 * 3600),
        arrivalDate: Date().addingTimeInterval(6 * 3600),
        hasTransfers: false,
        transferTitle: nil,
        carrier: CarrierModel(
            title: "Петрович",
            phone: "+7 (800) 555-35-35",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg",
            email: "example@mail.com"
        )
    )
]
