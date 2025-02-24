import UIKit

public struct DarkDesignSystem: DesignSystem {
    public let colors: DSColorPalette = DarkDSColorPalette()
    public let typography: DSTypography = DefaultDSTypography()
    public let spacing: DSSpacing = DefaultDSSpacing()
    
    public func makeExchangeCell(style: UITableViewCell.CellStyle = .default) -> DSExchangeCellDisplaying {
        DSExchangeCell(designSystem: self, style: style)
    }
}
