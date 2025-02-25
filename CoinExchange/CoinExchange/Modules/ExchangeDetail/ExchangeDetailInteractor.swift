import Foundation

protocol ExchangeDetailInteracting: AnyObject {
    func loadData()
}

final class ExchangeDetailInteractor {
    private let container: DependencyInjecting
    private let service: ExchangeDetailServicing
    private let presenter: ExchangeDetailPresenting
    private let exchange: Exchange

    init(
        service: ExchangeDetailServicing,
        presenter: ExchangeDetailPresenting,
        container: DependencyInjecting,
        exchange: Exchange
    ) {
        self.service = service
        self.presenter = presenter
        self.container = container
        self.exchange = exchange
    }
}

// MARK: - ExchangeDetailInteracting
extension ExchangeDetailInteractor: ExchangeDetailInteracting {
    public func loadData() {
        presenter.presentExchange(exchange)
    }
}
