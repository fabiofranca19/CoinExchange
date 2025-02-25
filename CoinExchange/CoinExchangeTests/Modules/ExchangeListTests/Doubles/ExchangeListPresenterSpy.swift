import XCTest
@testable import CoinExchange

public final class ExchangeListPresenterSpy: ExchangeListPresenting {
    public enum Message: AutoEquatable {
        case presentExchanges(exchanges: [Exchange], icons: [String:String])
        case presentLoading
        case hideLoading
        case presentError(message: String)
        case hideError
        case goToExchangeDetail(exchange: Exchange, iconUrl: String)
    }

    private(set) var messages: [Message] = []
    
    public func presentExchanges(exchanges: [Exchange], icons: [String:String]) {
        messages.append(.presentExchanges(exchanges: exchanges, icons: icons))
    }
    
    public func presentLoading() {
        messages.append(.presentLoading)
    }
    
    public func hideLoading() {
        messages.append(.hideLoading)
    }
    
    public func presentError(_ message: String) {
        messages.append(.presentError(message: message))
    }
    
    public func hideError() {
        messages.append(.hideError)
    }
    
    public func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        messages.append(.goToExchangeDetail(exchange: exchange, iconUrl: iconUrl))
    }
}
