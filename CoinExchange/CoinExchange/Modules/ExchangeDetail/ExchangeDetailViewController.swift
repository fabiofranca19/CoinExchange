import UIKit

protocol ExchangeDetailDisplaying: AnyObject {
}

final class ExchangeDetailViewController: UIViewController {
    private let interactor: ExchangeDetailInteracting
    private let designSystem: DesignSystem
    private let imageLoader: ImageLoading
    private let imageCache: ImageCaching
    
    init(
        interactor: ExchangeDetailInteracting,
        desingSystem: DesignSystem,
        imageLoader: ImageLoading,
        imageCache: ImageCaching
    ) {
        self.interactor = interactor
        self.designSystem = desingSystem
        self.imageLoader = imageLoader
        self.imageCache = imageCache
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - ExchangeDetailDisplaying
extension ExchangeDetailViewController: ExchangeDetailDisplaying {
}

// MARK: - ViewCode
extension ExchangeDetailViewController: ViewCode {
    public func setupHierarchy() {
        
    }
    
    public func setupConstraints() {
        
    }
    
    public func setupAdditionalConfigurations() {
        
    }
}
