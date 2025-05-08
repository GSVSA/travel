import Foundation

enum NetworkErrorType {
    case serverError
    case noInternetConnection
    
    var model: NetworkErrorModel {
        switch self {
        case .serverError:
            NetworkErrorModel(
                imageName: "ServerError",
                description: "Server error"
            )
        case .noInternetConnection:
            NetworkErrorModel(
                imageName: "NoInternet",
                description: "No Internet"
            )
        }
    }
}
