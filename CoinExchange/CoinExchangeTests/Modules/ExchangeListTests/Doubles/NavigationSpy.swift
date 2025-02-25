import XCTest
@testable import CoinExchange

public final class NavigationSpy: Navigating {
    public enum Message: AutoEquatable {
        case pushViewController(animated: Bool)
        case popViewController(animated: Bool)
    }
    
    private(set) var messages: [Message] = []
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        messages.append(.pushViewController(animated: animated))
    }
    
    public func popViewController(animated: Bool) {
        messages.append(.popViewController(animated: animated))
    }
    
    
}
