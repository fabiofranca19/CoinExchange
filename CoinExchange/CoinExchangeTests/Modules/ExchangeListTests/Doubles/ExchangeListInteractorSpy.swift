import XCTest
@testable import CoinExchange

public final class ExchangeListInteractorSpy: ExchangeListInteracting {
    public enum Message: AutoEquatable {
        case loadData
        case presentExchanges(index: Int)
    }

    private(set) var messages: [Message] = []
    
    public func loadData() {
        messages.append(.loadData)
    }
    public func cellTapped(at index: Int) {
        messages.append(.presentExchanges(index: index))
    }
}
