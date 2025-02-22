import UIKit

public protocol ExchangeListDisplaying: AnyObject {
    func displayExchanges(_ exchanges: [Exchange])
}

public final class ExchangeListViewController: UIViewController {
    private let interactor: ExchangeListInteracting
    
    init(interactor: ExchangeListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchExchanges()
    }
}

extension ExchangeListViewController: ExchangeListDisplaying {
    public func displayExchanges(_ exchanges: [Exchange]) {
        print(exchanges)
    }
}
