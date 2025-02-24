import Foundation

public protocol ExchangeListPresenting: AnyObject {
    func presentExchanges(exchanges: [Exchange])
    func presentExchanges(icons: [ExchangeIcon])
    func goToExchangeDetail()
}

public final class ExchangeListPresenter: ExchangeListPresenting {
    private let coordinator: ExchangeListCoordinating
    weak var controller: ExchangeListDisplaying?
    
    init(coordinator: ExchangeListCoordinating) {
        self.coordinator = coordinator
    }
    
    public func presentExchanges(exchanges: [Exchange]) {
        controller?.displayExchanges(exchanges)
    }
    
    public func presentExchanges(icons: [ExchangeIcon]) {
        
    }
    
    public func goToExchangeDetail() {
          
    }
}
