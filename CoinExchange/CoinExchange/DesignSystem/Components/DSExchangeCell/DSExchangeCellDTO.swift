import UIKit

public struct DSExchangeCellDTO: Equatable {
    let icon: UIImage?
    let title: String
    let subtitle: String
    let value: String
    
    public init(
        icon: UIImage? = UIImage(),
        title: String,
        subtitle: String,
        value: String
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.value = value
    }
}
