import UIKit

protocol ImageCaching: AnyObject {
    func getImage(for url: URL) -> UIImage?
    func setImage(_ image: UIImage, for url: URL)
}

final class ImageCache: ImageCaching {
    private let cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
