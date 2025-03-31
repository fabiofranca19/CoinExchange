import XCTest
@testable import CoinExchange

extension ExchangeIcon {
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
