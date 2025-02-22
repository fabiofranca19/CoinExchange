import Foundation

public protocol ExchangeListInteracting: AnyObject {
    func fetchExchanges()
}

public final class ExchangeListInteractor: ExchangeListInteracting {
    private let presenter: ExchangeListPresenting
    private let service: ExchangeListServicing
    
    init(presenter: ExchangeListPresenting, service: ExchangeListServicing) {
        self.presenter = presenter
        self.service = service
    }
    
    public func fetchExchanges() {
        service.fetchExchanges { [weak self] result in
            switch result {
            case let .success(model):
                self?.presenter.presentExchanges(exchanges: model)
            case .failure(_):
                break
            }
        }
    }
}
