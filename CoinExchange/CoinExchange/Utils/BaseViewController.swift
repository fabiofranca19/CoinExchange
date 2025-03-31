import UIKit

// MARK: - ViewCode
public class BaseViewController<Interactor>: UIViewController, ViewCode {
    public let interactor: Interactor
    public let designSystem: DesignSystem
    
    private lazy var loadingView: LoadingViewDisplaying = {
        let loadingView = designSystem.makeLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        return loadingView
    }()
    
    public init(
        interactor: Interactor,
        designSystem: DesignSystem
    ) {
        self.interactor = interactor
        self.designSystem = designSystem
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) { nil }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    public func setupHierarchy() {
        view.addSubview(loadingView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    public func setupAdditionalConfigurations() { }
    
    public func showLoading() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }
    }

    public func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
        }
    }
}
