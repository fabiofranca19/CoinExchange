import Foundation
import UIKit

protocol ExchangeDetailInteracting: AnyObject {
    func loadData()
}

final class ExchangeDetailInteractor {
    private let container: DependencyInjecting
    private let service: ExchangeDetailServicing
    private let presenter: ExchangeDetailPresenting
    private let exchange: Exchange
    private let iconUrl: String
    private let imageLoader: ImageLoading?
    private let imageCache: ImageCaching?

    init(
        service: ExchangeDetailServicing,
        presenter: ExchangeDetailPresenting,
        container: DependencyInjecting,
        exchange: Exchange,
        iconUrl: String
    ) {
        self.service = service
        self.presenter = presenter
        self.container = container
        self.exchange = exchange
        self.iconUrl = iconUrl
        self.imageLoader = container.resolve(ImageLoading.self)
        self.imageCache = container.resolve(ImageCaching.self)
    }
    
    private func loadIcon() {
        if let imageLoader = imageLoader,
           let imageCache = imageCache {
            imageLoader.loadImage(from: iconUrl, cache: imageCache) { [weak self] image in
                self?.presenter.presentExchangeIcon(image ?? UIImage())
            }
        }
    }
}

// MARK: - ExchangeDetailInteracting
extension ExchangeDetailInteractor: ExchangeDetailInteracting {
    func loadData() {
        loadIcon()
        presenter.presentExchange(exchange, iconUrl: iconUrl)
    }
}
