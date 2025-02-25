import UIKit

enum ExchangeDetailFactory {
    static func make(
        navigation: Navigating,
        _ container: DependencyInjecting,
        _ exchange: Exchange
    ) -> UIViewController {
        let designSystem = container.resolve(DesignSystem.self)
        let imageLoader = container.resolve(ImageLoading.self)
        let imageCache = container.resolve(ImageCaching.self)
        
        let container = DependencyContainer()
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
            container: container
        )
        let viewController = ExchangeDetailViewController(
            interactor: interactor,
            designSystem: designSystem,
            imageLoader: imageLoader,
            imageCache: imageCache
        )

        presenter.controller = viewController

        return viewController
    }
}
