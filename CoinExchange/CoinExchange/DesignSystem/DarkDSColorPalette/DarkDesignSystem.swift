import UIKit

public struct DarkDesignSystem: DesignSystem {
    public let colors: DSColorPalette = DarkDSColorPalette()
    public let typography: DSTypography = DefaultDSTypography()
    public let spacing: DSSpacing = DefaultDSSpacing()
    
    public func makeLoading() -> LoadingViewDisplaying {
        LoadingView()
    }
    
    public func makeExchangeCell(
        style: UITableViewCell.CellStyle
    ) -> DSExchangeCellDisplaying {
        DSExchangeCell(style: style, reuseIdentifier: nil)
    }
}
