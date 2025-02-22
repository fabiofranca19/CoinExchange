import UIKit

protocol Navigating {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
}

final class AppCoordinator: Navigating {
    private weak var navigationController: UINavigationController?
    private let container: DependencyInjecting
    
    init(
        _ navigationController: UINavigationController,
        _ container: DependencyInjecting
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func start() {
        navigationController?.setViewControllers([UIViewController()], animated: true)
    }
}
