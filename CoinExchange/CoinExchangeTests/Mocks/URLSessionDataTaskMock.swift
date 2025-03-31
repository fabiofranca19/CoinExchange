import Foundation
@testable import CoinExchange

final class URLSessionDataTaskMock: URLSessionDataTasking {
    enum Message: AutoEquatable {
        case resume
    }
    
    private(set) var messages: [Message] = []
    
    func resume() {
        messages.append(.resume)
    }
}
