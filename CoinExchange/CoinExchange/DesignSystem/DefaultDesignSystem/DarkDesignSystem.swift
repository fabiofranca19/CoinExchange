import UIKit

final class DefaultDesignSystem: DesignSystem {
    func makeLoading() -> LoadingViewDisplaying {
        LoadingView()
    }
    
    func makeExchangeCell(
        style: UITableViewCell.CellStyle
    ) -> DSExchangeCellDisplaying {
        DSExchangeCell(style: style, reuseIdentifier: nil)
    }
    
    func makeErrorView() -> any ErrorViewDisplaying {
        ErrorView()
    }
}
