import UIKit

public final class DefaultDesignSystem: DesignSystem {
    public func makeLoading() -> LoadingViewDisplaying {
        LoadingView()
    }
    
    public func makeExchangeCell(
        style: UITableViewCell.CellStyle
    ) -> DSExchangeCellDisplaying {
        DSExchangeCell(style: style, reuseIdentifier: nil)
    }
    
    public func makeErrorView() -> any ErrorViewDisplaying {
        ErrorView()
    }
}
