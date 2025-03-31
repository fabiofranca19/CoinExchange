import XCTest
@testable import CoinExchange

final class ExchangeListInteractorSpy: ExchangeListInteracting {
    enum Message: AutoEquatable {
        case loadData
        case presentExchanges(index: Int)
    }

    private(set) var messages: [Message] = []
    
    func loadData() {
        messages.append(.loadData)
    }
    func cellTapped(at index: Int) {
        messages.append(.presentExchanges(index: index))
    }
}
