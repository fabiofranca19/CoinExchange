import Foundation

public protocol ExchangeListInteracting: AnyObject {
    func loadData()
    
}

public final class ExchangeListInteractor: ExchangeListInteracting {
    private let presenter: ExchangeListPresenting
    private let service: ExchangeListServicing
    private let container: DependencyInjecting
    
    private var exchanges: [Exchange] = []
    private var exchangesIcons: [String: String] = [:]
    
    init(
        presenter: ExchangeListPresenting,
        service: ExchangeListServicing,
        container: DependencyInjecting
    ) {
        self.presenter = presenter
        self.service = service
        self.container = container
    }
    
    public func loadData() {
        presenter.presentLoading()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchExchanges { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case let .success(model):
                self?.exchanges = model
            case let .failure(error):
                break
            }
        }
        
        dispatchGroup.enter()
        fetchExchangesIcons { [weak self] result in
            defer { dispatchGroup.leave() }
            switch result {
            case let .success(model):
                self?.exchangesIcons = model.reduce(into: [String: String]()) { dictionary, icon in
                    dictionary[icon.exchangeId] = icon.url
                }
            case let .failure(error):
                break
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let exchanges = self?.exchanges, let icons = self?.exchangesIcons else { return }
            self?.presenter.presentExchanges(exchanges: exchanges, icons: icons)
            self?.presenter.hideLoading()
        }
    }

    private func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        service.fetchExchanges { result in
            completion(result)
        }
    }

    private func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void) {
        service.fetchExchangesIcons { result in
            completion(result)
        }
    }

}
