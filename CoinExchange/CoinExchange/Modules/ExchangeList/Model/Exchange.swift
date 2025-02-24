import Foundation

public struct Exchange: Codable {
    let name: String
    let exchangeId: String
    let volume1DayUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case exchangeId = "exchange_id"
        case volume1DayUsd = "volume_1day_usd"
    }
}
