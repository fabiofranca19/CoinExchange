import XCTest
@testable import CoinExchange

final class ExchangeListCoordinatorTests: XCTestCase {
    typealias Sut = ExchangeListCoordinator
    
    func testGoToExchangeDetail_ShouldNavigationPushViewController() {
        let (sut, doubles) = makeSut()
        let expectedIconUrl = "testeURL"
        let expectedExchange: Exchange = .fixture()
        
        sut.goToExchangeDetail(expectedExchange, iconUrl: expectedIconUrl)
        
        XCTAssertEqual(
            doubles.navigation.messages,
            [
                .pushViewController(animated: true)
            ]
        )
    }
}

private extension ExchangeListCoordinatorTests {
    final class Doubles {
        let navigation = NavigationSpy()
        let container = DependencyContainerMock()
    }
    
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (Sut, Doubles) {
        let doubles = Doubles()
        let sut = Sut(
            navigation: doubles.navigation,
            container: doubles.container
        )
        trackForMemoryLeaks(doubles, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, doubles)
    }
}
