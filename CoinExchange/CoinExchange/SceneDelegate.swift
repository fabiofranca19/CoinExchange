import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        let container = DependencyContainer()
        container.register(Servicing.self) {
            Service()
        }
        
        container.register(DesignSystem.self) {
            DarkDesignSystem()
        }
        
        let appCoordinator = AppCoordinator(
            navigationController,
            container
        )
        appCoordinator.start()
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

