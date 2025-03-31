import UIKit

protocol ExchangeDetailPresenting: AnyObject {
    func presentExchange(_ exchange: Exchange, iconUrl: String)
    func presentExchangeIcon(_ icon: UIImage)
}

final class ExchangeDetailPresenter {
    private let coordinator: ExchangeDetailCoordinating
    weak var controller: ExchangeDetailDisplaying?

    init(coordinator: ExchangeDetailCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExchangeDetailPresenting
extension ExchangeDetailPresenter: ExchangeDetailPresenting {
    func presentExchange(_ exchange: Exchange, iconUrl: String) {
        let dto = DSExchangeDetailDTO(
            name: exchange.name ?? exchange.exchangeId,
            website: exchange.website,
            exchangeId: exchange.exchangeId,
            symbolsCount: exchange.symbolsCount,
            volume1HourUsd: exchange.volume1HourUsd,
            volume1DayUsd: exchange.volume1DayUsd,
            volume1MonthUsd: exchange.volume1MonthUsd,
            rank: exchange.rank,
            dataQuoteStart: exchange.dataQuoteStart,
            dataQuoteEnd: exchange.dataQuoteEnd,
            dataTradeStart: exchange.dataTradeStart,
            dataTradeEnd: exchange.dataTradeEnd,
            iconUrl: iconUrl
        )
        
        controller?.displayDetail(dto)
    }
    
    func presentExchangeIcon(_ icon: UIImage) {
        controller?.displayDetailIcon(icon)
    }
}
