import XCTest
@testable import CoinExchange

final class ExchangeListPresenterSpy: ExchangeListPresenting {
    enum Message: AutoEquatable {
        case presentExchanges(exchanges: [Exchange], icons: [String:String])
        case presentLoading
        case hideLoading
        case presentError(message: String)
        case hideError
        case goToExchangeDetail(exchange: Exchange, iconUrl: String)
    }

    private(set) var messages: [Message] = []
    
    func presentExchanges(exchanges: [Exchange], icons: [String:String]) {
        messages.append(.presentExchanges(exchanges: exchanges, icons: icons))
    }
    
    func presentLoading() {
        messages.append(.presentLoading)
    }
    
    func hideLoading() {
        messages.append(.hideLoading)
    }
    
    func presentError(_ message: String) {
        messages.append(.presentError(message: message))
    }
    
    func hideError() {
        messages.append(.hideError)
    }
    
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        messages.append(.goToExchangeDetail(exchange: exchange, iconUrl: iconUrl))
    }
}
