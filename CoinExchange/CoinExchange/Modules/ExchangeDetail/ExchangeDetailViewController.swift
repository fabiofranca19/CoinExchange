import UIKit

protocol ExchangeDetailDisplaying: AnyObject {
    func displayDetail(_ detail: DSExchangeDetailDTO)
}

public struct DSExchangeDetailDTO {
    let name: String
    let website: String?
    let exchangeId: String
    let symbolsCount: Int
    let volume1HourUsd: Double
    let volume1DayUsd: Double
    let volume1MonthUsd: Double
    let rank: Int
    let dataQuoteStart: String?
    let dataQuoteEnd: String?
    let dataTradeStart: String?
    let dataTradeEnd: String?
    let iconUrl: String?
}

final class ExchangeDetailViewController: UIViewController {
    private let interactor: ExchangeDetailInteracting
    private let designSystem: DesignSystem
    private let imageLoader: ImageLoading
    private let imageCache: ImageCaching
    private var exchangeDetail: DSExchangeDetailDTO?
    
    // Componentes da UI
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DSColorPalette.Dark.primary.withAlphaComponent(0.9)
        view.layer.cornerRadius = DSSpacing.Default.space3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = DSSizes.Default.largeIcon / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = DSColorPalette.Dark.background
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DSTypography.Default.title
        label.textColor = DSColorPalette.Dark.textPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = DSColorPalette.Dark.background.withAlphaComponent(0.95)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DSSpacing.Default.space2
        return stackView
    }()
    
    private lazy var websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = DSTypography.Default.body
        button.setTitleColor(DSColorPalette.Dark.textPrimary, for: .normal)
        button.backgroundColor = DSColorPalette.Dark.primary
        button.layer.cornerRadius = DSSpacing.Default.space1
        button.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    init(
        interactor: ExchangeDetailInteracting,
        designSystem: DesignSystem,
        imageLoader: ImageLoading,
        imageCache: ImageCaching
    ) {
        self.interactor = interactor
        self.designSystem = designSystem
        self.imageLoader = imageLoader
        self.imageCache = imageCache
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
        buildView()
        detailsContainer.alpha = 0
        websiteButton.alpha = 0
    }
    
    @objc private func openWebsite() {
        guard let website = exchangeDetail?.website, let url = URL(string: website) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - ExchangeDetailDisplaying
extension ExchangeDetailViewController: ExchangeDetailDisplaying {
    public func displayDetail(_ detail: DSExchangeDetailDTO) {
        DispatchQueue.main.async { [weak self] in
            self?.exchangeDetail = detail
            self?.updateUI(with: detail)
            self?.animateUI()
        }
    }
}

// MARK: - ViewCode
extension ExchangeDetailViewController: ViewCode {
    public func setupHierarchy() {
        view.addSubview(headerView)
        headerView.addSubview(logoImageView)
        headerView.addSubview(titleLabel)
        view.addSubview(detailsContainer)
        detailsContainer.addSubview(detailsStackView)
        view.addSubview(websiteButton)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DSSpacing.Default.space3),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DSSpacing.Default.space3),
            
            logoImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: DSSpacing.Default.space3),
            logoImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: DSSizes.Default.largeIcon),
            logoImageView.heightAnchor.constraint(equalToConstant: DSSizes.Default.largeIcon),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: DSSpacing.Default.space2),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: DSSpacing.Default.space3),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -DSSpacing.Default.space3),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -DSSpacing.Default.space3),
            
            detailsContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: DSSpacing.Default.space3),
            detailsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            detailsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DSSpacing.Default.space3),
            detailsContainer.bottomAnchor.constraint(lessThanOrEqualTo: websiteButton.topAnchor, constant: -DSSpacing.Default.space3),
            
            detailsStackView.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: DSSpacing.Default.space2),
            detailsStackView.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: DSSpacing.Default.space2),
            detailsStackView.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -DSSpacing.Default.space2),
            detailsStackView.bottomAnchor.constraint(equalTo: detailsContainer.bottomAnchor, constant: -DSSpacing.Default.space2),
            
            websiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            websiteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -DSSpacing.Default.space3),
            websiteButton.widthAnchor.constraint(equalToConstant: 200),
            websiteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    public func setupAdditionalConfigurations() {
        view.backgroundColor = DSColorPalette.Dark.background
    }
}

// MARK: - Private Methods
private extension ExchangeDetailViewController {
    func updateUI(with detail: DSExchangeDetailDTO) {
        titleLabel.text = detail.name
        
        if let iconUrl = detail.iconUrl {
            imageLoader.loadImage(from: iconUrl, cache: imageCache) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
        
        detailsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addDetailRow(title: "Exchange ID", value: detail.exchangeId)
        addDetailRow(title: "Symbols Count", value: String(detail.symbolsCount))
        addDetailRow(title: "Rank", value: String(detail.rank))
        if let quoteStart = detail.dataQuoteStart {
            addDetailRow(title: "Quote Data Start", value: formatDate(quoteStart))
        }
        if let quoteEnd = detail.dataQuoteEnd {
            addDetailRow(title: "Quote Data End", value: formatDate(quoteEnd))
        }
        if let tradeStart = detail.dataTradeStart {
            addDetailRow(title: "Trade Data Start", value: formatDate(tradeStart))
        }
        if let tradeEnd = detail.dataTradeEnd {
            addDetailRow(title: "Trade Data End", value: formatDate(tradeEnd))
        }
        addDetailRow(title: "Volume (1h USD)", value: String(format: "%.2f", detail.volume1HourUsd))
        addDetailRow(title: "Volume (1d USD)", value: String(format: "%.2f", detail.volume1DayUsd))
        addDetailRow(title: "Volume (1m USD)", value: String(format: "%.2f", detail.volume1MonthUsd))
        
        websiteButton.setTitle(detail.website ?? "No website available", for: .normal)
        websiteButton.isEnabled = detail.website != nil
    }
    
    func addDetailRow(title: String, value: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DSTypography.Default.body
        label.textColor = DSColorPalette.Dark.textSecondary
        label.text = "\(title): "
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = DSTypography.Default.body
        valueLabel.textColor = DSColorPalette.Dark.textPrimary
        valueLabel.text = value
        valueLabel.numberOfLines = .zero
        
        let stackView = UIStackView(arrangedSubviews: [label, valueLabel])
        stackView.axis = .horizontal
        stackView.spacing = DSSpacing.Default.space1
        stackView.alignment = .top
        
        detailsStackView.addArrangedSubview(stackView)
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return dateString
    }
    
    func animateUI() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.detailsContainer.alpha = 1
            self.websiteButton.alpha = 1
            self.detailsContainer.transform = .identity
            self.websiteButton.transform = .identity
        }
    }
}
