import Foundation
@testable import CoinExchange

enum MockEndpoint: ApiEndpoint {
    case mock
    
    var baseURL: URL {
        return URL(string: "https://mock-base-url.com")!
    }
    
    var path: String {
        return "/mock-path"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String: String]? {
        return ["mockKey": "mockValue"]
    }
    
    var bodyParametes: [String: Any]? {
        return ["mockParam": "mockData"]
    }
    
    var headers: [String: String]? {
        return ["Authorization": "Bearer mockToken"]
    }
}
