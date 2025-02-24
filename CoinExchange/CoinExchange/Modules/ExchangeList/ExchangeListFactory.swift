import UIKit

public enum ExchangeListFactory {
    public static func make(
        navigation: Navigating,
        _ container: DependencyInjecting
    ) -> UIViewController {
        let designSystem = container.resolve(DesignSystem.self)
        let imageLoader = container.resolve(ImageLoading.self)
        let imageCache = container.resolve(ImageCaching.self)
        
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
            service: service,
            container: container
        )
        let controller = ExchangeListViewController(
            interactor: interactor,
            desingSystem: designSystem,
            imageLoader: imageLoader,
            imageCache: imageCache
        )
        
        presenter.controller = controller
        
        return controller
    }
}
