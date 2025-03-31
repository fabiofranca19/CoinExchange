import XCTest
@testable import CoinExchange

struct MockResponse: Decodable {
    let message: String
}

final class ServiceTests: XCTestCase {
    typealias Sut = Service
    
    func testExecute_SuccessfulResponse() {
        let (sut, doubles) = makeSut()
        
        sut.execute(MockEndpoint.mock) { (result: Result<MockResponse, Error>) in }

        XCTAssertEqual(doubles.sessionMock.dataTask.messages, [
            .resume
        ])
    }
}

private extension ServiceTests {
    final class Doubles {
        let sessionMock = URLSessionMock()
    }
    
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (Sut, Doubles) {
        let doubles = Doubles()
        let sut = Sut(urlSession: doubles.sessionMock)
        trackForMemoryLeaks(doubles, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, doubles)
    }
}
