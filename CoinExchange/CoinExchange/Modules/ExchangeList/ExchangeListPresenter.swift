import Foundation

public protocol ExchangeListPresenting: AnyObject {
    func presentExchanges(exchanges: [Exchange], icons: [String:String])
    func presentLoading()
    func hideLoading()
    func presentError(_ message: String)
    func hideError()
    func goToExchangeDetail(_ exchange: Exchange)
}

public final class ExchangeListPresenter {
    private let coordinator: ExchangeListCoordinating
    weak var controller: ExchangeListDisplaying?
    
    init(coordinator: ExchangeListCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExchangeListPresenting
extension ExchangeListPresenter: ExchangeListPresenting {
    public func presentExchanges(exchanges: [Exchange], icons: [String:String]) {
        let exchangesDTO = exchanges.compactMap {
            DSExchangeCellDTO(
                icon: icons[$0.exchangeId] ?? "",
                title: $0.name ?? "",
                subtitle: $0.exchangeId,
                value: String.formattedAsUSD(from: $0.volume1DayUsd)
            )
        }
        controller?.displayExchanges(exchangesDTO)
    }
    
    public func presentLoading() {
        controller?.displayLoading()
    }
    
    public func hideLoading() {
        controller?.hideLoading()
    }
    
    public func presentError(_ message: String) {
        controller?.displayError(message)
    }
    
    public func hideError() {
        controller?.hideError()
    }
    
    public func goToExchangeDetail(_ exchange: Exchange) {
        coordinator.goToExchangeDetail(exchange)
    }
}
