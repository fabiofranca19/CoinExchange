import XCTest
@testable import CoinExchange

final class ExchangeDetailInteractorTests: XCTestCase {
    typealias Sut = ExchangeDetailInteractor
    
    func testLoadData_ShouldCallPresenterWithCorrectExchangeAndIconUrl() {
        let (sut, doubles) = makeSut()
        let expectedExchange: Exchange = .fixture()
        let expectedIconUrl = "testIconUrl"
        
        sut.loadData()
        
        XCTAssertEqual(
            doubles.presenter.messages,
            [
                .presentExchangeIcon,
                .presentExchange(exchanges: expectedExchange, iconUrl: expectedIconUrl)
            ]
        )
    }
}

private extension ExchangeDetailInteractorTests {
    final class Doubles {
        let service = ExchangeDetailServiceMock()
        let presenter = ExchangeDetailPresenterSpy()
        let container = DependencyContainerMock()
    }
    
    func makeSut(
        exchange: Exchange = .fixture(),
        iconUrl: String = "testIconUrl",
        file: StaticString = #file,
        line: UInt = #line
    ) -> (Sut, Doubles) {
        let doubles = Doubles()
        let sut = Sut(
            service: doubles.service,
            presenter: doubles.presenter,
            container: doubles.container,
            exchange: exchange,
            iconUrl: iconUrl
        )
        trackForMemoryLeaks(doubles, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, doubles)
    }
}
