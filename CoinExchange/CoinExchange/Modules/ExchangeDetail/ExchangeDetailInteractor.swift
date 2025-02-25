import Foundation

protocol ExchangeDetailInteracting: AnyObject {
    func loadData()
}

final class ExchangeDetailInteractor {
    private let container: DependencyInjecting
    private let service: ExchangeDetailServicing
    private let presenter: ExchangeDetailPresenting
    private let exchange: Exchange
    private let iconUrl: String

    init(
        service: ExchangeDetailServicing,
        presenter: ExchangeDetailPresenting,
        container: DependencyInjecting,
        exchange: Exchange,
        iconUrl: String
    ) {
        self.service = service
        self.presenter = presenter
        self.container = container
        self.exchange = exchange
        self.iconUrl = iconUrl
    }
}

// MARK: - ExchangeDetailInteracting
extension ExchangeDetailInteractor: ExchangeDetailInteracting {
    public func loadData() {
        presenter.presentExchange(exchange, iconUrl: iconUrl)
    }
}
