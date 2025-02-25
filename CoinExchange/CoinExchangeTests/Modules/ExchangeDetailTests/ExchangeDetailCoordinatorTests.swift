import XCTest
@testable import CoinExchange

final class ExchangeDetailCoordinatorTests: XCTestCase {
    typealias Sut = ExchangeDetailCoordinator
    
    func testPopViewController_ShouldNavigationPopViewController() {
        let (sut, doubles) = makeSut()
        
        sut.popViewController()
        
        XCTAssertEqual(
            doubles.navigation.messages,
            [
                .popViewController(animated: true)
            ]
        )
    }
}

private extension ExchangeDetailCoordinatorTests {
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
