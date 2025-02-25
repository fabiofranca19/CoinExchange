import XCTest
@testable import CoinExchange

public final class DependencyContainerMock: DependencyInjecting {
    private var factories: [ObjectIdentifier: () -> Any] = [:]
    
    private let dependencies: [Any]
    
    init() {
        self.dependencies = [
            ServiceMock(),
            DesignSystemMock(),
            ImageCacheMock(),
            ImageLoaderMock()
        ]
    }
    
    public func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = ObjectIdentifier(type)
        factories[key] = factory
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        let key = ObjectIdentifier(T.self)
        if let factory = factories[key] as? () -> T {
            return factory()
        }
        
        let resolved = dependencies.compactMap { $0 as? T }
        switch resolved.first {
        case .none:
            fatalError("DependencyContainerMock could not resolve dependency: \(T.self)")
        case .some where resolved.count > 1:
            fatalError("DependencyContainerMock resolved multiple dependencies for: \(T.self)")
        case .some(let mock):
            return mock
        }
    }
}

extension DependencyContainerMock {
    func resolve() -> Servicing {
        let resolved = dependencies.compactMap { $0 as? Servicing }.first
        return resolved ?? ServiceMock()
    }
    
    func resolve() -> DesignSystem {
        let resolved = dependencies.compactMap { $0 as? DesignSystem }.first
        return resolved ?? DesignSystemMock()
    }
    
    func resolve() -> ImageCaching {
        let resolved = dependencies.compactMap { $0 as? ImageCaching }.first
        return resolved ?? ImageCacheMock()
    }
    
    func resolve() -> ImageLoading {
        let resolved = dependencies.compactMap { $0 as? ImageLoading }.first
        return resolved ?? ImageLoaderMock()
    }
}
