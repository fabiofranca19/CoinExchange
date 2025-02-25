import XCTest
@testable import CoinExchange

public final class ExchangeDetailCoordinatorSpy: ExchangeDetailCoordinating {
    public enum Message: AutoEquatable {
        case popViewController
    }

    private(set) var messages: [Message] = []
    
    public func popViewController() {
        messages.append(.popViewController)
    }
}
