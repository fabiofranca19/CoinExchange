import UIKit

public protocol DesignSystem {
    var colors: DSColorPalette { get }
    var typography: DSTypography { get }
    var spacing: DSSpacing { get }
    
    func makeExchangeCell(style: UITableViewCell.CellStyle) -> DSExchangeCellDisplaying
}
