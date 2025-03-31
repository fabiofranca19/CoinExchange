import UIKit

protocol ExchangeListDisplaying: UIViewController {
    func displayExchanges(_ exchanges: [DSExchangeCellDTO])
    func displayLoading()
    func hideLoading()
    func displayError(_ message: String)
    func hideError()
}

final class ExchangeListViewController: UIViewController {
    private let interactor: ExchangeListInteracting
    private let designSystem: DesignSystem
    private let imageLoader: ImageLoading
    private let imageCache: ImageCaching
    private var exchangesCells: [DSExchangeCellDTO] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DSTypography.Default.title
        label.text = "Exchange List"
        label.textColor = DSColorPalette.Default.textPrimary
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.register(DSExchangeCell.self, forCellReuseIdentifier: DSExchangeCell.identifier)
        return tableView
    }()
    
    private lazy var loadingView: LoadingViewDisplaying = {
        let loadingView = designSystem.makeLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var errorView: ErrorViewDisplaying = {
        let errorView = designSystem.makeErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.onRetry = { [weak self] in
            self?.interactor.loadData()
        }
        return errorView
    }()
    
    init(
        interactor: ExchangeListInteracting,
        desingSystem: DesignSystem,
        imageLoader: ImageLoading,
        imageCache: ImageCaching
    ) {
        self.interactor = interactor
        self.designSystem = desingSystem
        self.imageLoader = imageLoader
        self.imageCache = imageCache
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
        buildView()
    }
}

// MARK: - ExchangeListDisplaying
extension ExchangeListViewController: ExchangeListDisplaying {
    func displayExchanges(_ exchanges: [DSExchangeCellDTO]) {
        DispatchQueue.main.async { [weak self] in
            self?.exchangesCells = exchanges
            self?.tableView.reloadData()
        }
    }
    
    func displayLoading() {
        loadingView.startAnimating()
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
    }
    
    func displayError(_ message: String) {
        self.tableView.isUserInteractionEnabled = false
        errorView.showError(message: message, designSystem: designSystem)
    }
    
    func hideError() {
        errorView.hideError()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ExchangeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangesCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exchangesDTO = exchangesCells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DSExchangeCell.identifier,
            for: indexPath
        ) as? (UITableViewCell & DSExchangeCellDisplaying) else {
            return UITableViewCell()
        }
        
        cell.accessibilityIdentifier = "exchangeCell_\(indexPath.row)"
        cell.updateCell(exchangesDTO)
        imageLoader.loadImage(
            from: exchangesDTO.iconUrl,
            cache: imageCache
        ) { [weak cell] icon in
            cell?.updateImage(icon)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageLoader.cancelLoad(for: exchangesCells[indexPath.row].iconUrl)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.cellTapped(at: indexPath.row)
    }
}

extension ExchangeListViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DSSpacing.Default.space3),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DSSpacing.Default.space3),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DSSpacing.Default.space3),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DSSpacing.Default.space3),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurations() {
        view.backgroundColor = DSColorPalette.Default.background
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}
