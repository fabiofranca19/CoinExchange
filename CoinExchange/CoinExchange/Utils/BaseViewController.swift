import UIKit

// MARK: - ViewCode
class BaseViewController<Interactor>: UIViewController, ViewCode {
    let interactor: Interactor
    let designSystem: DesignSystem
    
    private lazy var loadingView: LoadingViewDisplaying = {
        let loadingView = designSystem.makeLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        return loadingView
    }()
    
    init(
        interactor: Interactor,
        designSystem: DesignSystem
    ) {
        self.interactor = interactor
        self.designSystem = designSystem
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func setupHierarchy() {
        view.addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfigurations() { }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingView.startAnimating()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.stopAnimating()
        }
    }
}
