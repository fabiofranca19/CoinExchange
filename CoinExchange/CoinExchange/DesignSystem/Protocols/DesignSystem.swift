import UIKit

public protocol DesignSystem {
    func makeLoading() -> LoadingViewDisplaying
    func makeExchangeCell(style: UITableViewCell.CellStyle) -> DSExchangeCellDisplaying
    func makeErrorView() -> ErrorViewDisplaying
}
