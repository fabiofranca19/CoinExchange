import XCTest
@testable import CoinExchange

public final class ExchangeDetailServiceMock: ExchangeDetailServicing {
    public var isSuccess: Bool = true
    public var expectedExchange: Exchange = .fixture()
    public var expectedIcon: ExchangeIcon = .fixture(exchangeId: "testId", url: "testUrl")
    public var expectedError: Error = MockError.generic
}
