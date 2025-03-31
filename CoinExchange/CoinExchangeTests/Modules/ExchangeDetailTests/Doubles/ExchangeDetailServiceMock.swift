import XCTest
@testable import CoinExchange

final class ExchangeDetailServiceMock: ExchangeDetailServicing {
    var isSuccess: Bool = true
    var expectedExchange: Exchange = .fixture()
    var expectedIcon: ExchangeIcon = .fixture(exchangeId: "testId", url: "testUrl")
    var expectedError: Error = MockError.generic
}
