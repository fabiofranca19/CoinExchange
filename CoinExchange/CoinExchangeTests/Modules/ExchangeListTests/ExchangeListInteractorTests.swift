import XCTest
@testable import CoinExchange

final class ExchangeListInteractorTests: XCTestCase {
    typealias Sut = ExchangeListInteractor
    
    func testLoadData_WhenServiceCallIsSuccess_ShouldPresentExchanges() {
        let (sut, doubles) = makeSut()
        doubles.serviceMock.isSuccess = true
        
        let icon = doubles.serviceMock.exprectedExchangesIcon.first!
        let icons: [String: String] = [icon.exchangeId: icon.url]
        
        let expectation = XCTestExpectation(description: "Esperar o carregamento assíncrono dos dados")
        
        sut.loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        sut.cellTapped(at: 0)
        
        XCTAssertEqual(
            doubles.presenterSpy.messages,
            [
                .presentLoading,
                .hideError,
                .presentExchanges(exchanges: doubles.serviceMock.expectedExchanges, icons: icons),
                .hideLoading,
                .goToExchangeDetail(exchange: .fixture(), iconUrl: "")
            ]
        )
    }
    
    func testLoadData_WhenServiceCallIsFailure_ShouldPresentExchanges() {
        let (sut, doubles) = makeSut()
        doubles.serviceMock.isSuccess = false
        
        let errorMessage = doubles.serviceMock.expectedError.localizedDescription
        
        let expectation = XCTestExpectation(description: "Esperar o carregamento assíncrono dos dados")
        
        sut.loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(
            doubles.presenterSpy.messages,
            [
                .presentLoading,
                .hideError,
                .presentError(message: errorMessage),
                .hideLoading
            ]
        )
    }
}

private extension ExchangeListInteractorTests {
    final class Doubles {
        let presenterSpy = ExchangeListPresenterSpy()
        let serviceMock = ExchangeListServiceMock()
    }
    
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (Sut, Doubles) {
        let doubles = Doubles()
        let sut = Sut(
            presenter: doubles.presenterSpy,
            service: doubles.serviceMock,
            container: DependencyContainerMock()
        )
        trackForMemoryLeaks(doubles, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, doubles)
    }
}
