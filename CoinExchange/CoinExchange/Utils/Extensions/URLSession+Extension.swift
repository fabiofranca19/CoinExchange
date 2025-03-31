import Foundation

extension URLSessionDataTask: URLSessionDataTasking {}

extension URLSession: URLSessioning {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTasking {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
