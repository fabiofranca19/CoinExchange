import Foundation

public protocol ExchangeListServicing: AnyObject {
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void)
}

public final class ExchangeListService: ExchangeListServicing {
    private let container: DependencyInjecting
    
    init(container: DependencyInjecting) {
        self.container = container
    }
    
    public func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        let service = container.resolve(Servicing.self)
        
        service.execute(ExchangeListEndpoint.exchanges) { result in
            completion(result)
        }
    }
}
