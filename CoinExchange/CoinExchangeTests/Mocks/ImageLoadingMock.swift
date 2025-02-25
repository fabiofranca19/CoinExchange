import UIKit
@testable import CoinExchange

final class ImageLoaderMock: ImageLoading {
    public enum Message: AutoEquatable {
        case loadImage(urlString: String, cache: ImageCaching)
        case cancelLoad(urlString: String)
    }
    
    private(set) var messages: [Message] = []
    
    public var expectedImage: UIImage? = nil
    
    func loadImage(from urlString: String, cache: ImageCaching, completion: @escaping (UIImage?) -> Void) {
        messages.append(.loadImage(urlString: urlString, cache: cache))
        completion(expectedImage)
    }
    
    func cancelLoad(for urlString: String) {
        messages.append(.cancelLoad(urlString: urlString))
    }
}
