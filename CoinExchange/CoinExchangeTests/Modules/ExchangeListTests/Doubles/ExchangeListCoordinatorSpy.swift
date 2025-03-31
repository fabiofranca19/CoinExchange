import XCTest
@testable import CoinExchange

final class ExchangeListCoordinatorSpy: ExchangeListCoordinating {
enum Message: AutoEquatable {
        case goToExchangeDetail(exchange: Exchange, iconUrl: String)
    }
    
    private(set) var messages: [Message] = []
    
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        messages.append(.goToExchangeDetail(exchange: exchange, iconUrl: iconUrl))
    }
}
