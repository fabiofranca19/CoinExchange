import XCTest
@testable import CoinExchange

public final class ExchangeListViewControllerSpy: UIViewController, ExchangeListDisplaying {
    public enum Message: AutoEquatable {
        case displayExchanges(exchanges: [DSExchangeCellDTO])
        case displayLoading
        case displayError(message: String)
        case hideLoading
        case hideError
    }
    
    private(set) var messages: [Message] = []
    
    public func displayExchanges(_ exchanges: [DSExchangeCellDTO]) {
        messages.append(.displayExchanges(exchanges: exchanges))
    }
    
    public func displayLoading() {
        messages.append(.displayLoading)
    }
    
    public func displayError(_ message: String) {
        messages.append(.displayError(message: message))
    }
    
    public func hideLoading() {
        messages.append(.hideLoading)
    }
    
    public func hideError() {
        messages.append(.hideError)
    }
}
