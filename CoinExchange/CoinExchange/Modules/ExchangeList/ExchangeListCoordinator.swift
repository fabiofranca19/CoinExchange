import Foundation

public protocol ExchangeListCoordinating: AnyObject {
    func goToExchangeDetail(_ exchange: Exchange)
}

public final class ExchangeListCoordinator {
    private let navigation: Navigating
    private let container: DependencyInjecting
    
    init(
        navigation: Navigating,
        container: DependencyInjecting
    ) {
        self.navigation = navigation
        self.container = container
    }
}

// MARK: - ExchangeListCoordinating
extension ExchangeListCoordinator: ExchangeListCoordinating {
    public func goToExchangeDetail(_ exchange: Exchange) {
        let controller = ExchangeDetailFactory.make(
            navigation: navigation,
            container,
            exchange
        )
        navigation.pushViewController(controller, animated: true)
    }
}
