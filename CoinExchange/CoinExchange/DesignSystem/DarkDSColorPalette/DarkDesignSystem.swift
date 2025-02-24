import UIKit

public struct DarkDesignSystem: DesignSystem {
    public let colors: DSColorPalette = DarkDSColorPalette()
    public let typography: DSTypography = DefaultDSTypography()
    public let spacing: DSSpacing = DefaultDSSpacing()
}
