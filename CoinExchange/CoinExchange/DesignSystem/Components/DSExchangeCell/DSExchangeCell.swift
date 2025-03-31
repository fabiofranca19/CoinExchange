import UIKit

protocol DSExchangeCellDisplaying: UITableViewCell {
    func updateCell(_ dto: DSExchangeCellDTO)
    func updateImage(_ icon: UIImage?)
}

final class DSExchangeCell: UITableViewCell {
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
        label.font = DSTypography.Default.caption
        label.textColor = DSColorPalette.Default.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = DSTypography.Default.body
        label.textColor = DSColorPalette.Default.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = DSTypography.Default.caption
        label.textColor = DSColorPalette.Default.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = DSSpacing.Default.space1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = DSColorPalette.Default.primary
        view.layer.cornerRadius = DSSpacing.Default.space2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let targetHeight = iconImageView.frame.height + DSSpacing.Default.space3 * 2
        return CGSize(width: targetSize.width, height: targetHeight)
    }
}

extension DSExchangeCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(textStackView)
        containerView.addSubview(valueLabel)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DSSpacing.Default.space3),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DSSpacing.Default.space3),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DSSpacing.Default.space3),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: DSSpacing.Default.space3),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: DSSpacing.Default.space5),
            iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -DSSpacing.Default.space5),
            iconImageView.widthAnchor.constraint(equalToConstant: DSSizes.Default.smallIcon),
            iconImageView.heightAnchor.constraint(equalToConstant: DSSizes.Default.smallIcon),
            
            textStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: DSSpacing.Default.space3),
            textStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -DSSpacing.Default.space3),
            valueLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
        contentView.backgroundColor = DSColorPalette.Default.background
        containerView.layer.masksToBounds = true
    }
}

extension DSExchangeCell: DSExchangeCellDisplaying {
    func updateCell(_ dto: DSExchangeCellDTO) {
        titleLabel.text = dto.title
        subtitleLabel.text = dto.subtitle
        valueLabel.text = dto.value
        
        buildView()
    }
    
    func updateImage(_ icon: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.iconImageView.image = icon
        }
    }
}
