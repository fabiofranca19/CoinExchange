import Foundation

public protocol ExchangeListServicing: AnyObject {
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void)
    func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void)
}

public final class ExchangeListService: ExchangeListServicing {
    private let container: DependencyInjecting
    private let service: Servicing?
    
    init(container: DependencyInjecting) {
        self.container = container
        self.service = container.resolve(Servicing.self)
    }
    
    public func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        fetch(endpoint: .exchanges, completion: completion)
    }

    public func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void) {
        fetch(endpoint: .logos, completion: completion)
    }
    
    private func fetch<T: Codable>(endpoint: ExchangeListEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let service = service else { return }
        service.execute(endpoint, completion: completion)
    }
}
