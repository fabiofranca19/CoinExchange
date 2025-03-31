import XCTest
@testable import CoinExchange

final class NavigationSpy: Navigating {
    enum Message: AutoEquatable {
        case pushViewController(animated: Bool)
        case popViewController(animated: Bool)
    }
    
    private(set) var messages: [Message] = []
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        messages.append(.pushViewController(animated: animated))
    }
    
    func popViewController(animated: Bool) {
        messages.append(.popViewController(animated: animated))
    }
    
    
}
