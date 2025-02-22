import UIKit

public enum ExchangeListFactory {
    public static func make(
        navigation: Navigating,
        _ container: DependencyInjecting
    ) -> UIViewController {
        let coordinator = ExchangeListCoordinator(
            navigation: navigation,
            container: container
        )
        let service = ExchangeListService(
            container: container
        )
        let presenter = ExchangeListPresenter(
            coordinator: coordinator
        )
        let interactor = ExchangeListInteractor(
            presenter: presenter,
            service: service
        )
        let controller = ExchangeListViewController(
            interactor: interactor
        )
        
        presenter.controller = controller
        
        return controller
    }
}
