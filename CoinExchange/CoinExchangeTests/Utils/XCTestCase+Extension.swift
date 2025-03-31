import Foundation
import XCTest

// TODO: Essa classe foi adicionada para resolver possíveis problemas de memory leaks
extension XCTestCase {
    /// Assert that SUT and Test Doubles have been deallocated from memory.
    /// This helps identify potential memory leaks.
    func assertDeallocated<T>(_ sut: inout T,
                              _ testDoubles: AnyObject...,
                              file: StaticString = #filePath,
                              line: UInt = #line) where T: AnyObject {
        XCTAssertTrue(isKnownUniquelyReferenced(&sut),
                      "Object has more than one strong reference.",
                      file: file,
                      line: line)

        testDoubles.forEach { trackForMemoryLeaks($0, file: file, line: line) }
    }

    /// Assert that an instance is deallocated from memory
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        if #available(iOS 13, *) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(
                    instance,
                    "Instance should have been deallocated. Potential memory leak.",
                    file: file,
                    line: line
                )
            }
        }
    }

    /// Metodo responsavel por validarmos memory Leaks tanto para o sut quanto testDoubles muito voltado a ensinar quais casos de testes causam memory leak
    /// com isso queremos evitar problemas de retain cycle na aplicação
    func assertNotDeallocated<T>(_ sut: inout T,
                              _ testDoubles: AnyObject...,
                              file: StaticString = #filePath,
                              line: UInt = #line) where T: AnyObject {
        if #available(iOS 13, *) {
            let hasRetainCycleSut = isKnownUniquelyReferenced(&sut) == false
            testDoubles.forEach { instance in
                addTeardownBlock { [weak instance] in
                    XCTAssertTrue(hasRetainCycleSut || instance != nil)
                }
            }
        }
    }
}
