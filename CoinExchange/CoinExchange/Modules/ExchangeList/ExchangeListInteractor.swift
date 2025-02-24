import Foundation

public protocol ExchangeListInteracting: AnyObject {
    func loadData()
    
}

public final class ExchangeListInteractor: ExchangeListInteracting {
    private let presenter: ExchangeListPresenting
    private let service: ExchangeListServicing
    
    init(presenter: ExchangeListPresenting, service: ExchangeListServicing) {
        self.presenter = presenter
        self.service = service
    }
    
    public func loadData() {
        
    }
    
    private func fetchExchanges() {
        service.fetchExchanges { [weak self] result in
            switch result {
            case let .success(model):
                self?.presenter.presentExchanges(exchanges: model)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func fetchExchangesIcons() {
        service.fetchExchangesIcons { [weak self] result in
            switch result {
            case let .success(model):
                self?.presenter.presentExchanges(icons: model)
            case let .failure(error):
                print(error)
            }
        }
    }
}
