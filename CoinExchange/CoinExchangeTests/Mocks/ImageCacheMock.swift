import UIKit
@testable import CoinExchange

final class ImageCacheMock: ImageCaching {
    enum Message: AutoEquatable {
        case getImage(url: URL)
        case setImage(image: UIImage, url: URL)
    }
    
    private(set) var messages: [Message] = []
    
    private var cache: [URL: UIImage] = [:]
    
    func getImage(for url: URL) -> UIImage? {
        messages.append(.getImage(url: url))
        return cache[url]
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        messages.append(.setImage(image: image, url: url))
        cache[url] = image
    }
}
