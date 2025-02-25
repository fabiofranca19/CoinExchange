import XCTest
@testable import CoinExchange

public extension Exchange {
    static func fixture(
        exchangeId: String = "",
        website: String? = nil,
        name: String? = nil,
        dataQuoteStart: String? = nil,
        dataQuoteEnd: String? = nil,
        dataOrderbookStart: String? = nil,
        dataOrderbookEnd: String? = nil,
        dataTradeStart: String? = nil,
        dataTradeEnd: String? = nil,
        symbolsCount: Int = 0,
        volume1HourUsd: Double = 0.0,
        volume1DayUsd: Double = 0.0,
        volume1MonthUsd: Double = 0.0,
        rank: Int = 0
    ) -> Self {
        Exchange(
            exchangeId: exchangeId,
            website: website,
            name: name,
            dataQuoteStart: dataQuoteStart,
            dataQuoteEnd: dataQuoteEnd,
            dataOrderbookStart: dataOrderbookStart,
            dataOrderbookEnd: dataOrderbookEnd,
            dataTradeStart: dataTradeStart,
            dataTradeEnd: dataTradeEnd,
            symbolsCount: symbolsCount,
            volume1HourUsd: volume1HourUsd,
            volume1DayUsd: volume1DayUsd,
            volume1MonthUsd: volume1MonthUsd,
            rank: rank
        )
    }
}
