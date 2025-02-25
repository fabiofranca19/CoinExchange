import XCTest
@testable import CoinExchange

public enum MockError: Error {
    case generic
}

public enum MockEndpoint: ApiEndpoint {
    public var baseURL: URL {
        return URL(string: "https://mock-base-url.com")!
    }
    
    public var path: String {
        return "/mock-path"
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var queryParameters: [String: String]? {
        return ["mockKey": "mockValue"]
    }
    
    public var bodyParametes: [String: Any]? {
        return ["mockParam": "mockData"]
    }
    
    public var headers: [String: String]? {
        return ["Authorization": "Bearer mockToken"]
    }
}

public final class ServiceMock: Servicing {
    public enum Message: AutoEquatable {
        case execute(expectedEndpoint: ApiEndpoint)
    }
    
    private(set) var messages: [Message] = []
    
    public var isSuccess: Bool = true
    public var mockResponse: Decodable?
    public var endpointExpected: ApiEndpoint?
    
    public func execute<E: Decodable>(
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
