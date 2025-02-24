import Foundation

public struct DSExchangeCellDTO: Equatable {
    let iconUrl: String
    let title: String
    let subtitle: String
    let value: String
    
    public init(
        icon: String,
        title: String,
        subtitle: String,
        value: String
    ) {
        self.iconUrl = icon
        self.title = title
        self.subtitle = subtitle
        self.value = value
    }
}
