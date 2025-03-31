import XCTest
@testable import CoinExchange

enum MockError: Error {
    case generic
}

enum MockEndpoint: ApiEndpoint {
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

final class ServiceMock: Servicing {
    enum Message: AutoEquatable {
        case execute(expectedEndpoint: ApiEndpoint)
    }
    
    private(set) var messages: [Message] = []
    
    var isSuccess: Bool = true
    var mockResponse: Decodable?
    var endpointExpected: ApiEndpoint?
    
    func execute<E: Decodable>(
        _ endpoint: ApiEndpoint,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        messages.append(.execute(expectedEndpoint: endpoint))
        self.endpointExpected = endpoint
        if isSuccess, let response = mockResponse as? E {
            return completion(.success(response))
        }
        completion(.failure(MockError.generic))
    }
}
