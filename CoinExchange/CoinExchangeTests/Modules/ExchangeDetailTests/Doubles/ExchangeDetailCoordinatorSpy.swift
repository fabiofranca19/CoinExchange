import XCTest
@testable import CoinExchange

final class ExchangeDetailCoordinatorSpy: ExchangeDetailCoordinating {
    enum Message: AutoEquatable {
        case popViewController
    }

    private(set) var messages: [Message] = []
    
    func popViewController() {
        messages.append(.popViewController)
    }
}
