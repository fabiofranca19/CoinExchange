import Foundation

protocol ExchangeListCoordinating: AnyObject {
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String)
}

final class ExchangeListCoordinator {
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
    func goToExchangeDetail(_ exchange: Exchange, iconUrl: String) {
        let controller = ExchangeDetailFactory.make(
            navigation: navigation,
            container,
            exchange,
            iconUrl
        )
        navigation.pushViewController(controller, animated: true)
    }
}
