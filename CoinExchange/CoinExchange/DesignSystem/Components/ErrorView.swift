import UIKit

public protocol ErrorViewDisplaying: UIView {
    func showError(message: String, designSystem: DesignSystem?)
    func hideError()
    var onRetry: (() -> Void)? { get set }
}

public final class ErrorView: UIView {
    public var onRetry: (() -> Void)?
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = DSColorPalette.Default.textPrimary
        label.backgroundColor = DSColorPalette.Default.errorBackground
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tentar novamente", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = DSColorPalette.Default.primary
        button.tintColor = DSColorPalette.Default.textPrimary
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func retryTapped() {
        hideError()
        onRetry?()
    }
}

extension ErrorView: ViewCode {
    public func setupHierarchy() {
        addSubview(retryButton)
        addSubview(messageLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: DSSpacing.Default.space3),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DSSpacing.Default.space3),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DSSpacing.Default.space3),
                
                retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: DSSpacing.Default.space1),
                retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                retryButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -DSSpacing.Default.space3)
            ])
    }
    
    public func setupAdditionalConfigurations() {
        backgroundColor = .clear
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        isUserInteractionEnabled = true
    }
}

extension ErrorView: ErrorViewDisplaying {
    public func showError(message: String, designSystem: DesignSystem?) {
        messageLabel.text = message
        isHidden = false
    }
    
    public func hideError() {
        isHidden = true
    }
}
