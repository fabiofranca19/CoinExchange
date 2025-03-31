import Foundation

protocol ExchangeListServicing: AnyObject {
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void)
    func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void)
}

final class ExchangeListService {
    private let container: DependencyInjecting
    private let service: Servicing?
    
    init(container: DependencyInjecting) {
        self.container = container
        self.service = container.resolve(Servicing.self)
    }
    
    private func fetch<T: Codable>(endpoint: ExchangeListEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let service = service else { return }
        service.execute(endpoint, completion: completion)
    }
}

// MARK: - ExchangeListServicing
extension ExchangeListService: ExchangeListServicing {
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        fetch(endpoint: .exchanges, completion: completion)
    }

    func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void) {
        fetch(endpoint: .logos, completion: completion)
    }
}
                                    
