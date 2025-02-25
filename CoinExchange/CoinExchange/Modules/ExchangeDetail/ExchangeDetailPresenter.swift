protocol ExchangeDetailPresenting: AnyObject {
    func presentExchange(_ exchange: Exchange)
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
    func presentExchange(_ exchange: Exchange) {
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
            dataTradeEnd: exchange.dataTradeEnd
        )
        
        controller?.displayDetail(dto)
    }
}
