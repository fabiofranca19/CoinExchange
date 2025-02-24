import Foundation

public struct Exchange: Codable {
    let name: String?
    let exchangeId: String
    let volume1DayUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case exchangeId = "exchange_id"
        case volume1DayUsd = "volume_1day_usd"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.exchangeId = try container.decode(String.self, forKey: .exchangeId)
        self.volume1DayUsd = try container.decode(Double.self, forKey: .volume1DayUsd)
    }
}

