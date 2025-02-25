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
}

final class ExchangeDetailViewController: UIViewController {
    private let interactor: ExchangeDetailInteracting
    private let designSystem: DesignSystem
    private let imageLoader: ImageLoading
    private let imageCache: ImageCaching
    private var exchangeDetail: DSExchangeDetailDTO?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DSTypography.Default.title
        label.textColor = DSColorPalette.Dark.textPrimary
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = DSTypography.Default.body
        button.setTitleColor(DSColorPalette.Dark.textPrimary, for: .normal)
        button.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DSSpacing.Default.space2
        return stackView
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
        }
    }
}

// MARK: - ViewCode
extension ExchangeDetailViewController: ViewCode {
    public func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(detailsStackView)
        view.addSubview(websiteButton)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DSSpacing.Default.space3),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -DSSpacing.Default.space3),
            
            detailsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DSSpacing.Default.space3),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DSSpacing.Default.space3),
            
            websiteButton.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: DSSpacing.Default.space3),
            websiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            websiteButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            websiteButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -DSSpacing.Default.space3)
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
        label.textColor = DSColorPalette.Dark.textPrimary
        label.text = "\(title): \(value)"
        detailsStackView.addArrangedSubview(label)
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
}
