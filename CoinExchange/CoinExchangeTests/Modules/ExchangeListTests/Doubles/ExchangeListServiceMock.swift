import XCTest
@testable import CoinExchange

final class ExchangeListServiceMock: ExchangeListServicing {
    var isSuccess: Bool = true
    var expectedExchanges: [Exchange] = [.fixture()]
    var exprectedExchangesIcon: [ExchangeIcon] = [.fixture(exchangeId: "testeId", url: "testUrl")]
    var expectedError: Error = MockError.generic
    
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        if isSuccess {
            return completion(.success(expectedExchanges))
        }
        completion(.failure(expectedError))
    }
    
    func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void) {
        if isSuccess {
            return completion(.success(exprectedExchangesIcon))
        }
        completion(.failure(expectedError))
    }
}
