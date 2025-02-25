import XCTest
@testable import CoinExchange

final class ExchangeListPresenterTests: XCTestCase {
    typealias Sut = ExchangeListPresenter
    
    func testPresentExchanges_ShouldDisplayExchanges() {
        let (sut, doubles) = makeSut()
        let exchange: Exchange = .fixture()
        let expectedsDTO: [DSExchangeCellDTO] = [.fixture(value: "$0,00")]
        
        sut.presentExchanges(exchanges: [exchange], icons: [:])
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .displayExchanges(exchanges: expectedsDTO)
            ]
        )
    }
    
    func testPresentLoading_ShouldDisplayLoading() {
        let (sut, doubles) = makeSut()
        
        sut.presentLoading()
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .displayLoading
            ]
        )
    }
    
    func testHideLoading_ShouldHideLoading() {
        let (sut, doubles) = makeSut()
        
        sut.hideLoading()
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .hideLoading
            ]
        )
    }
    
    func testGoToExchangeDetail_ShouldDisplayError() {
        let (sut, doubles) = makeSut()
        let expectedMessage = "Error"
        
        sut.presentError(expectedMessage)
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .displayError(message: expectedMessage)
            ]
        )
    }
    
    func testHideError_ShouldHideError() {
        let (sut, doubles) = makeSut()
        
        sut.hideError()
        
        XCTAssertEqual(
            doubles.controller.messages,
            [
                .hideError
            ]
        )
    }
    
    func testHideError_ShouldCoordinatorGoToExchangeDetail() {
        let (sut, doubles) = makeSut()
        let expectedIconUrl = "testeURL"
        let expectedExchange: Exchange = .fixture()
        
        sut.goToExchangeDetail(expectedExchange, iconUrl: expectedIconUrl)
        
        XCTAssertEqual(
            doubles.coordinator.messages,
            [
                .goToExchangeDetail(exchange: expectedExchange, iconUrl: expectedIconUrl)
            ]
        )
    }
}

private extension ExchangeListPresenterTests {
    final class Doubles {
        let coordinator = ExchangeListCoordinatorSpy()
        let controller = ExchangeListViewControllerSpy()
    }
    
    func makeSut(
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
