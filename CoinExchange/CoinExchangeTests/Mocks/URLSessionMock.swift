import Foundation
@testable import CoinExchange

final class URLSessionMock: URLSessioning {
    enum Message: AutoEquatable {
        case dataTask(request: URLRequest)
    }
    
    private(set) var messages: [Message] = []
    
    private(set) var dataTask: URLSessionDataTaskMock
    
    init() {
        self.dataTask = URLSessionDataTaskMock()
    }
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTasking {
        dataTask
    }
}
