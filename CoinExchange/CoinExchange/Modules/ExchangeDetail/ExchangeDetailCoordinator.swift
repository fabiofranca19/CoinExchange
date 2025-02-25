import UIKit

protocol ExchangeDetailCoordinating: AnyObject {
    func popViewController()
}

final class ExchangeDetailCoordinator {
    private let navigation: Navigating
    private let container: DependencyInjecting

    init(navigation: Navigating, container: DependencyInjecting) {
        self.navigation = navigation
        self.container = container
    }
}

// MARK: - ExchangeDetailCoordinating
extension ExchangeDetailCoordinator: ExchangeDetailCoordinating {
    public func popViewController() {
        navigation.popViewController(animated: true)
    }
}
