import Foundation

enum ExchangeListEndpoint: ApiEndpoint {
    case exchanges
    case logos
    
    var baseURL: URL {
        return URL(string: "https://rest.coinapi.io/v1")!
    }
    
    var path: String {
        switch self {
        case .exchanges:
            return "/exchanges"
        case .logos:
            return "/exchanges/icons/40"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String : String]? {
        return nil
    }
    
    var bodyParametes: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return ["X-CoinAPI-Key": ConfigService.apiKey]
    }
}
