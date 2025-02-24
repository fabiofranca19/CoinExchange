import UIKit

public protocol DSExchangeCellDisplaying: UITableViewCell {
    func updateCell(_ dto: DSExchangeCellDTO, designSystem: DesignSystem)
    func updateImage(_ icon: UIImage?)
}

public final class DSExchangeCell: UITableViewCell {
    static let identifier = "DSExchangeCellIdentifier"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var designSystem: DesignSystem?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        guard let designSystem = designSystem else { return CGSize() }
        let targetHeight = iconImageView.frame.height + designSystem.spacing.space3 * 2
        return CGSize(width: targetSize.width, height: targetHeight)
    }
}

extension DSExchangeCell: ViewCode {
    public func setupHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(textStackView)
        containerView.addSubview(valueLabel)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
    }
    
    public func setupConstraints() {
        guard let designSystem = designSystem else { return }
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: designSystem.spacing.space3),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -designSystem.spacing.space3),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -designSystem.spacing.space3),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: designSystem.spacing.space3),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: designSystem.spacing.space5),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -designSystem.spacing.space5),
            iconImageView.widthAnchor.constraint(equalToConstant: designSystem.spacing.space4),
            iconImageView.heightAnchor.constraint(equalToConstant: designSystem.spacing.space4),
            
            textStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: designSystem.spacing.space3),
            textStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -designSystem.spacing.space3),
            valueLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    public func setupAdditionalConfigurations() {
        guard let designSystem = designSystem else { return }
        
        contentView.backgroundColor = designSystem.colors.background
        containerView.backgroundColor = designSystem.colors.primary
        containerView.layer.cornerRadius = designSystem.spacing.space2
        containerView.layer.masksToBounds = true
        
        setupLabel(
            titleLabel,
            font: designSystem.typography.body,
            color: designSystem.colors.textPrimary
        )
        setupLabel(
            subtitleLabel,
            font: designSystem.typography.caption,
            color: designSystem.colors.textSecondary
        )
        setupLabel(
            valueLabel,
            font: designSystem.typography.caption,
            color: designSystem.colors.textPrimary
        )
        
        textStackView.spacing = designSystem.spacing.space1
    }
}

extension DSExchangeCell: DSExchangeCellDisplaying {
    public func updateCell(_ dto: DSExchangeCellDTO, designSystem: DesignSystem) {
        self.designSystem = designSystem
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        valueLabel.text = dto.value
        
        buildView()
    }
    
    public func updateImage(_ icon: UIImage?) {
        
        iconImageView.image = icon
    }
}

private extension DSExchangeCell {
    func setupLabel(_ label: UILabel, font: UIFont, color: UIColor) {
        label.font = font
        label.textColor = color
    }
}
