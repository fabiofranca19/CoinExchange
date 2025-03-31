import XCTest
@testable import CoinExchange

final class ExchangeDetailViewControllerSpy: ExchangeDetailDisplaying {
    enum Message: AutoEquatable {
        case displayDetail(detail: DSExchangeDetailDTO)
        case displayDetailIcon(icon: UIImage)
    }

    private(set) var messages: [Message] = []
    
    func displayDetail(_ detail: DSExchangeDetailDTO) {
        messages.append(.displayDetail(detail: detail))
    }
    
    func displayDetailIcon(_ icon: UIImage) {
        messages.append(.displayDetailIcon(icon: icon))
    }
}
