import XCTest
@testable import CoinExchange

public extension ExchangeIcon {
    static func fixture(
        exchangeId: String = "",
        url: String = ""
    ) -> Self {
        ExchangeIcon(
            exchangeId: exchangeId,
            url: url
        )
    }
}
