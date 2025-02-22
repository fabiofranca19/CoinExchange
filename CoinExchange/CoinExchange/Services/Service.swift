import Foundation

final class Service: Servicing {
    func execute<E: Decodable>(
        _ endpoint: ApiEndpoint,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        
    }
}
