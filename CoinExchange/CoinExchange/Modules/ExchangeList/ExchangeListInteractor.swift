import Foundation

public protocol ExchangeListInteracting: AnyObject {
    func loadData()
    
}

public final class ExchangeListInteractor: ExchangeListInteracting {
    private let presenter: ExchangeListPresenting
    private let service: ExchangeListServicing
    private let container: DependencyInjecting
    
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
        let designSystem = container.resolve(DesignSystem.self)
        fetchExchanges(designSystem)
    }
    
    private func fetchExchanges(_ designSystem: DesignSystem) {
        service.fetchExchanges { [weak self] result in
            switch result {
            case let .success(model):
                self?.presenter.presentExchanges(
                    exchanges: model,
                    designSystem: designSystem
                )
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
