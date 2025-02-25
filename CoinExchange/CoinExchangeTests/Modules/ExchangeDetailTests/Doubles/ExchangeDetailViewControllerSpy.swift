import XCTest
@testable import CoinExchange

public final class ExchangeDetailViewControllerSpy: ExchangeDetailDisplaying {
    public enum Message: AutoEquatable {
        case displayDetail(detail: DSExchangeDetailDTO)
    }

    private(set) var messages: [Message] = []
    
    public func displayDetail(_ detail: DSExchangeDetailDTO) {
        messages.append(.displayDetail(detail: detail))
    }
}
