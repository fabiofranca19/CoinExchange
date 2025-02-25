import XCTest
@testable import CoinExchange

final class ExchangeDetailPresenterTests: XCTestCase {
    typealias Sut = ExchangeDetailPresenter
    
    func testLoadData_ShouldCallPresenterWithCorrectExchangeAndIconUrl() {
        let (sut, doubles) = makeSut()
        let expectedIconUrl = "testIconUrl"
        let expectedExchange: DSExchangeDetailDTO = .fixture(iconUrl: expectedIconUrl)
        
        sut.presentExchange(.fixture(), iconUrl: expectedIconUrl)
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .displayDetail(detail: expectedExchange)
            ]
        )
    }
}

private extension ExchangeDetailPresenterTests {
    final class Doubles {
        let coordinator = ExchangeDetailCoordinatorSpy()
        let controller = ExchangeDetailViewControllerSpy()
    }
    
    func makeSut(
        exchange: Exchange = .fixture(),
        iconUrl: String = "testIconUrl",
        file: StaticString = #file,
        line: UInt = #line
    ) -> (Sut, Doubles) {
        let doubles = Doubles()
        let sut = Sut(
            coordinator: doubles.coordinator
        )
        sut.controller = doubles.controller
        trackForMemoryLeaks(doubles, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, doubles)
    }
}
