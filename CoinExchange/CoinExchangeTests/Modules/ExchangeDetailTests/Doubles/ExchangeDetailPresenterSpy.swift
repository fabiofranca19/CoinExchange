import XCTest
@testable import CoinExchange

public final class ExchangeDetailPresenterSpy: ExchangeDetailPresenting {
    public enum Message: AutoEquatable {
        case presentExchange(exchanges: Exchange, iconUrl: String)
        case presentExchangeIcon
    }

    private(set) var messages: [Message] = []
    
    public func presentExchange(_ exchange: Exchange, iconUrl: String) {
        messages.append(.presentExchange(exchanges: exchange, iconUrl: iconUrl))
    }
    
    public func presentExchangeIcon(_ icon: UIImage) {
        messages.append(.presentExchangeIcon)
    }
}
