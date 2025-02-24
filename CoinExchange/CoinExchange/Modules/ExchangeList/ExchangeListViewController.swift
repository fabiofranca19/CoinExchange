import UIKit

public protocol ExchangeListDisplaying: AnyObject {
    func displayExchanges(_ exchanges: [DSExchangeCellDTO])
    func displayLoading()
    func hideLoading()
}

public final class ExchangeListViewController: UIViewController {
    private let interactor: ExchangeListInteracting
    private let designSystem: DesignSystem
    private let imageLoader: ImageLoading
    private let imageCache: ImageCaching
    private var exchangesCells: [DSExchangeCellDTO] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = designSystem.typography.title
        label.text = "Exchange List"
        label.textColor = designSystem.colors.textPrimary
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DSExchangeCell.self, forCellReuseIdentifier: DSExchangeCell.identifier)
        return tableView
    }()
    
    private lazy var loadingView: LoadingViewDisplaying = {
        let loadingView = designSystem.makeLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
        buildView()
    }
}

extension ExchangeListViewController: ExchangeListDisplaying {
    public func displayExchanges(_ exchanges: [DSExchangeCellDTO]) {
        DispatchQueue.main.async { [weak self] in
            self?.exchangesCells = exchanges
            self?.tableView.reloadData()
        }
    }
    
    public func displayLoading() {
        loadingView.startAnimating()
    }
    
    public func hideLoading() {
        loadingView.stopAnimating()
    }
}

extension ExchangeListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangesCells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exchangesDTO = exchangesCells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DSExchangeCell.identifier,
            for: indexPath
        ) as? (UITableViewCell & DSExchangeCellDisplaying) else {
            return UITableViewCell()
        }
        
        cell.updateCell(exchangesDTO, designSystem: designSystem)
        imageLoader.loadImage(
            from: exchangesDTO.iconUrl,
            cache: imageCache
        ) { [weak cell] icon in
            cell?.updateImage(icon)
        }
        
        return cell
    }
}

extension ExchangeListViewController: ViewCode {
    public func setupHierarchy() {
        view.addSubview(loadingView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: designSystem.spacing.space3),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: designSystem.spacing.space3),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: designSystem.spacing.space3),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func setupAdditionalConfigurations() {
        view.backgroundColor = designSystem.colors.background
    
        tableView.dataSource = self
        tableView.delegate = self
    }
}
