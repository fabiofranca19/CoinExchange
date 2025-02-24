import Foundation

public enum ExchangeListEndpoint: ApiEndpoint {
    case exchanges
    case logos
    
    public var baseURL: URL {
        return URL(string: "https://rest.coinapi.io/v1")!
    }
    
    public var path: String {
        switch self {
        case .exchanges:
            return "/exchanges"
        case .logos:
            return "/exchanges/icons/45"
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var queryParameters: [String : String]? {
        return nil
    }
    
    public var bodyParametes: [String : Any]? {
        return nil
    }
    
    public var headers: [String : String]? {
        return ["X-CoinAPI-Key": "9b2d60e2-7517-4984-bad9-76dab344c5a3"]
    }
}
