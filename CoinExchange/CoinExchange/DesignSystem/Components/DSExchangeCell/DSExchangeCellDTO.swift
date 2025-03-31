import Foundation

struct DSExchangeCellDTO: Equatable {
    let iconUrl: String
    let title: String
    let subtitle: String
    let value: String
    
    init(
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
