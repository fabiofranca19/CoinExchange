import XCTest
@testable import CoinExchange

public extension DSExchangeDetailDTO {
    static func fixture(
        name: String = "",
        website: String? = nil,
        exchangeId: String = "",
        symbolsCount: Int = 0,
        volume1HourUsd: Double = 0.0,
        volume1DayUsd: Double = 0.0,
        volume1MonthUsd: Double = 0.0,
        rank: Int = 0,
        dataQuoteStart: String? = nil,
        dataQuoteEnd: String? = nil,
        dataTradeStart: String? = nil,
        dataTradeEnd: String? = nil,
        iconUrl: String? = nil
    ) -> Self {
        DSExchangeDetailDTO(
            name: name,
            website: website,
            exchangeId: exchangeId,
            symbolsCount: symbolsCount,
            volume1HourUsd: volume1HourUsd,
            volume1DayUsd: volume1DayUsd,
            volume1MonthUsd: volume1MonthUsd,
            rank: rank,
            dataQuoteStart: dataQuoteStart,
            dataQuoteEnd: dataQuoteEnd,
            dataTradeStart: dataTradeStart,
            dataTradeEnd: dataTradeEnd,
            iconUrl: iconUrl
        )
    }
}
