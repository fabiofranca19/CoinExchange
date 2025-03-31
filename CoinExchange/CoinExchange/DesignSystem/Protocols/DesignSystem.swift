import UIKit

protocol DesignSystem: AnyObject {
    func makeLoading() -> LoadingViewDisplaying
    func makeExchangeCell(style: UITableViewCell.CellStyle) -> DSExchangeCellDisplaying
    func makeErrorView() -> ErrorViewDisplaying
}
