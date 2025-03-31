import XCTest
@testable import CoinExchange

extension DSExchangeCellDTO {
    static func fixture(
        icon: String = "",
        title: String = "",
        subtitle: String = "",
        value: String = ""
    ) -> Self {
        DSExchangeCellDTO(
            icon: icon,
            title: title,
            subtitle: subtitle,
            value: value
        )
    }
}
