import UIKit

public protocol DSExchangeCellDisplaying: UITableViewCell {
    func updateCell(_ dto: DSExchangeCellDTO)
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
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let designSystem: DesignSystem
    
    init(
        designSystem: DesignSystem,
        style: UITableViewCell.CellStyle = .default,
        reuseIdentifier: String? = nil
    ) {
        self.designSystem = designSystem
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let targetHeight = iconImageView.frame.height + designSystem.spacing.space3 * 2
        return CGSize(width: targetSize.width, height: targetHeight)
    }
}

extension DSExchangeCell: ViewCode {
    public func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(valueLabel)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: designSystem.spacing.space3),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: designSystem.spacing.space3),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -designSystem.spacing.space3),
            iconImageView.widthAnchor.constraint(equalToConstant: designSystem.spacing.space4),
            iconImageView.heightAnchor.constraint(equalToConstant: designSystem.spacing.space4),
            
            textStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: designSystem.spacing.space3),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -designSystem.spacing.space3),
            valueLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    public func setupAdditionalConfigurations() {
        self.backgroundColor = designSystem.colors.primary
        
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
    public func updateCell(_ dto: DSExchangeCellDTO) {
        iconImageView.image = dto.icon
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        valueLabel.text = dto.value
    }
}

private extension DSExchangeCell {
    func setupLabel(_ label: UILabel, font: UIFont, color: UIColor) {
        label.font = font
        label.textColor = color
    }
}
