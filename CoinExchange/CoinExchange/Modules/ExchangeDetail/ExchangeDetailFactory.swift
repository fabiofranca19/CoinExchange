import UIKit

enum ExchangeDetailFactory {
    static func make(
        navigation: Navigating,
        _ container: DependencyInjecting,
        _ exchange: Exchange,
        _ iconUrl: String
    ) -> UIViewController {
        let designSystem = container.resolve(DesignSystem.self)
        
        let service = ExchangeDetailService(
            container: container
        )
        let coordinator = ExchangeDetailCoordinator(
            navigation: navigation,
            container: container
        )
        let presenter = ExchangeDetailPresenter(
            coordinator: coordinator
        )
        let interactor = ExchangeDetailInteractor(
            service: service,
            presenter: presenter,
            container: container,
            exchange: exchange,
            iconUrl: iconUrl
        )
        let viewController = ExchangeDetailViewController(
            interactor: interactor,
            designSystem: designSystem
        )

        presenter.controller = viewController

        return viewController
    }
}
