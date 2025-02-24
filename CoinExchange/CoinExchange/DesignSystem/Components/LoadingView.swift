import UIKit

public protocol LoadingViewDisplaying: AnyObject, UIView {
    func startAnimating()
    func stopAnimating()
}

public final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: ViewCode {
    public func setupHierarchy() {
        addSubview(activityIndicator)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func setupAdditionalConfigurations() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        isHidden = true
    }
}

extension LoadingView: LoadingViewDisplaying {
    public func startAnimating() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    public func stopAnimating() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
