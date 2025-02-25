import Foundation

protocol ExchangeDetailInteracting: AnyObject {
}

final class ExchangeDetailInteractor {
    private let container: DependencyInjecting
    private let service: ExchangeDetailServicing
    private let presenter: ExchangeDetailPresenting

    init(
        service: ExchangeDetailServicing,
        presenter: ExchangeDetailPresenting,
        container: DependencyInjecting
    ) {
        self.service = service
        self.presenter = presenter
        self.container = container
    }
}

// MARK: - ExchangeDetailInteracting
extension ExchangeDetailInteractor: ExchangeDetailInteracting {
}
