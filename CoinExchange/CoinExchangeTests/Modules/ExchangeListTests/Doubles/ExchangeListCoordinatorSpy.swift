import XCTest
@testable import CoinExchange

public final class ExchangeListCoordinatorSpy: ExchangeListCoordinating {
    public enum Message: AutoEquatable {
        case goToExchangeDetail(exchange: Exchange, iconUrl: String)
    }
    
    private(set) var messages: [Message] = []
    
    public func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        messages.append(.goToExchangeDetail(exchange: exchange, iconUrl: iconUrl))
    }
}
