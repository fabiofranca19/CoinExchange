import UIKit

extension UIImageView {
    private static var imageCache = NSCache<NSURL, UIImage>()
    
    func loadImage(from url: URL?) {
        guard let url = url else { return }
        
        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            
            UIImageView.imageCache.setObject(image, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        task.resume()
    }
}

