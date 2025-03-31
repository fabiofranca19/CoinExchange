import UIKit

protocol LoadingViewDisplaying: AnyObject, UIView {
    func startAnimating()
    func stopAnimating()
}

final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
}

extension LoadingView: ViewCode {
    func setupHierarchy() {
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        isHidden = true
    }
}

extension LoadingView: LoadingViewDisplaying {
    func startAnimating() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
