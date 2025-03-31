import XCTest
@testable import CoinExchange

final class ExchangeListViewControllerSpy: UIViewController, ExchangeListDisplaying {
    enum Message: AutoEquatable {
        case displayExchanges(exchanges: [DSExchangeCellDTO])
        case displayLoading
        case displayError(message: String)
        case hideLoading
        case hideError
    }
    
    private(set) var messages: [Message] = []
    
    func displayExchanges(_ exchanges: [DSExchangeCellDTO]) {
        messages.append(.displayExchanges(exchanges: exchanges))
    }
    
    func displayLoading() {
        messages.append(.displayLoading)
    }
    
    func displayError(_ message: String) {
        messages.append(.displayError(message: message))
    }
    
    func hideLoading() {
        messages.append(.hideLoading)
    }
    
    func hideError() {
        messages.append(.hideError)
    }
}
