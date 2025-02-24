import UIKit

public protocol ExchangeListDisplaying: AnyObject {
    func displayExchanges(_ exchanges: [DSExchangeCellDisplaying])
    func displayExchanges(_ icons: [ExchangeIcon])
}

public final class ExchangeListViewController: UIViewController {
    private let interactor: ExchangeListInteracting
    private var exchangesCells: [DSExchangeCellDisplaying] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DSExchangeCell.self, forCellReuseIdentifier: DSExchangeCell.identifier)
        return tableView
    }()
    
    init(interactor: ExchangeListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadData()
    }
}

extension ExchangeListViewController: ExchangeListDisplaying {
    public func displayExchanges(_ exchanges: [DSExchangeCellDisplaying]) {
        self.exchangesCells = exchanges
        tableView.reloadData()
    }
    
    public func displayExchanges(_ icons: [ExchangeIcon]) {
        print(icons)
    }
}

extension ExchangeListViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangesCells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exchangesCell = exchangesCells[indexPath.row]
        return exchangesCell
    }
}
