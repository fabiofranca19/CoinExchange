import XCTest
@testable import CoinExchange

final class ExchangeDetailPresenterSpy: ExchangeDetailPresenting {
    enum Message: AutoEquatable {
        case presentExchange(exchanges: Exchange, iconUrl: String)
        case presentExchangeIcon
    }

    private(set) var messages: [Message] = []
    
    func presentExchange(_ exchange: Exchange, iconUrl: String) {
        messages.append(.presentExchange(exchanges: exchange, iconUrl: iconUrl))
    }
    
    func presentExchangeIcon(_ icon: UIImage) {
        messages.append(.presentExchangeIcon)
    }
}
