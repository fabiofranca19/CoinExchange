import Foundation

protocol DependencyInjecting {
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    func resolve<T>(_ type: T.Type) -> T
}

final class DependencyContainer: DependencyInjecting {
    private var dependencies: [String: Any] = [:]
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        guard let factory = dependencies[key] as? () -> T else {
            fatalError("Nenhuma dependecia registrada para o tipo: \(T.self)")
        }
        
        return factory()
    }
}
