import Foundation

protocol ExchangeListPresenting: AnyObject {
    func presentExchanges(exchanges: [Exchange], icons: [String:String])
    func presentLoading()
    func hideLoading()
    func presentError(_ message: String)
    func hideError()
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String)
}

final class ExchangeListPresenter {
    private let coordinator: ExchangeListCoordinating
    weak var controller: ExchangeListDisplaying?
    
    init(coordinator: ExchangeListCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExchangeListPresenting
extension ExchangeListPresenter: ExchangeListPresenting {
    func presentExchanges(exchanges: [Exchange], icons: [String:String]) {
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
    
    func presentLoading() {
        controller?.displayLoading()
    }
    
    func hideLoading() {
        controller?.hideLoading()
    }
    
    func presentError(_ message: String) {
        controller?.displayError(message)
    }
    
    func hideError() {
        controller?.hideError()
    }
    
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        coordinator.goToExchangeDetail(exchange, iconUrl: iconUrl)
    }
}
