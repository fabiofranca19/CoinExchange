import UIKit

public struct DefaultDSTypography: DSTypography {
    public let body: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public let title: UIFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    public let caption: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
}

