import UIKit

protocol ImageLoading: AnyObject {
    func loadImage(from urlString: String, cache: ImageCaching, completion: @escaping (UIImage?) -> Void)
    func cancelLoad(for urlString: String)
}

final class ImageLoader: ImageLoading {
    private var runningTasks = [String: URLSessionDataTask]()
    
    func loadImage(from urlString: String, cache: ImageCaching, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = cache.getImage(for: url) {
            completion(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak cache] data, _, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                completion(nil)
                return
            }
            
            cache?.setImage(image, for: url)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        runningTasks[urlString] = task
        task.resume()
    }
    
    func cancelLoad(for urlString: String) {
        runningTasks[urlString]?.cancel()
        runningTasks.removeValue(forKey: urlString)
    }
}


