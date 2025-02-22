import Foundation

public protocol ExchangeListCoordinating: AnyObject {
    func goToExchangeDetail()
}

public final class ExchangeListCoordinator: ExchangeListCoordinating {
    private let navigation: Navigating
    private let container: DependencyInjecting
    
    init(
        navigation: Navigating,
        container: DependencyInjecting
    ) {
        self.navigation = navigation
        self.container = container
    }
    
    public func goToExchangeDetail() {
        
    }
}
