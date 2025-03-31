import XCTest
@testable import CoinExchange

enum MockError: Error {
    case generic
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
