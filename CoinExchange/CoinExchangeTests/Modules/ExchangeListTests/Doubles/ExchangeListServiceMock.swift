import XCTest
@testable import CoinExchange

public final class ExchangeListServiceMock: ExchangeListServicing {
    public var isSuccess: Bool = true
    public var expectedExchanges: [Exchange] = [.fixture()]
    public var exprectedExchangesIcon: [ExchangeIcon] = [.fixture(exchangeId: "testeId", url: "testUrl")]
    public var expectedError: Error = MockError.generic
    
    public func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {
        if isSuccess {
            return completion(.success(expectedExchanges))
        }
        completion(.failure(expectedError))
    }
    
    public func fetchExchangesIcons(completion: @escaping (Result<[ExchangeIcon], Error>) -> Void) {
        if isSuccess {
            return completion(.success(exprectedExchangesIcon))
        }
        completion(.failure(expectedError))
    }
}
