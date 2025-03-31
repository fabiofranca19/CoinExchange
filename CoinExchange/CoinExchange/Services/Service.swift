import Foundation

final class Service: Servicing {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func execute<E: Decodable>(
        _ endpoint: ApiEndpoint,
        completion: @escaping (Result<E, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        ) else {
            completion(.failure(
                NSError(domain: "Erro na URL", code: 0, userInfo: nil))
            )
            return
        }
        
        if let queryParameters = endpoint.queryParameters {
            urlComponents.queryItems = queryParameters.map { 
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(
                NSError(domain: "Erro na URL", code: 0, userInfo: nil))
            )
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let bodyParameters = endpoint.bodyParametes {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: bodyParameters, options: []
                )
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Sem data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(E.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
