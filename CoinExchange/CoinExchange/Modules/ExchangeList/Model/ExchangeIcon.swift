import Foundation

struct ExchangeIcon: Codable {
    let exchangeId: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case url
    }
}

