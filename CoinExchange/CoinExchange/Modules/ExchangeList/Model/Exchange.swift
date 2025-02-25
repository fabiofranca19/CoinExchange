import Foundation

import Foundation

public struct Exchange: Codable {
    let exchangeId: String
    let website: String?
    let name: String?
    let dataQuoteStart: String?
    let dataQuoteEnd: String?
    let dataOrderbookStart: String?
    let dataOrderbookEnd: String?
    let dataTradeStart: String?
    let dataTradeEnd: String?
    let symbolsCount: Int
    let volume1HourUsd: Double
    let volume1DayUsd: Double
    let volume1MonthUsd: Double
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case symbolsCount = "data_symbols_count"
        case volume1HourUsd = "volume_1hrs_usd"
        case volume1DayUsd = "volume_1day_usd"
        case volume1MonthUsd = "volume_1mth_usd"
        case rank
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.exchangeId = try container.decode(String.self, forKey: .exchangeId)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.dataQuoteStart = try container.decodeIfPresent(String.self, forKey: .dataQuoteStart)
        self.dataQuoteEnd = try container.decodeIfPresent(String.self, forKey: .dataQuoteEnd)
        self.dataOrderbookStart = try container.decodeIfPresent(String.self, forKey: .dataOrderbookStart)
        self.dataOrderbookEnd = try container.decodeIfPresent(String.self, forKey: .dataOrderbookEnd)
        self.dataTradeStart = try container.decodeIfPresent(String.self, forKey: .dataTradeStart)
        self.dataTradeEnd = try container.decodeIfPresent(String.self, forKey: .dataTradeEnd)
        self.symbolsCount = try container.decode(Int.self, forKey: .symbolsCount)
        self.volume1HourUsd = try container.decode(Double.self, forKey: .volume1HourUsd)
        self.volume1DayUsd = try container.decode(Double.self, forKey: .volume1DayUsd)
        self.volume1MonthUsd = try container.decode(Double.self, forKey: .volume1MonthUsd)
        self.rank = try container.decode(Int.self, forKey: .rank)
    }
}

