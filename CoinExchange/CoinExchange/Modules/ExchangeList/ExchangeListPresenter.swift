import Foundation

public protocol ExchangeListPresenting: AnyObject {
    func presentExchanges(exchanges: [Exchange], designSystem: DesignSystem)
    func presentExchanges(icons: [ExchangeIcon])
    func goToExchangeDetail()
}

public final class ExchangeListPresenter: ExchangeListPresenting {
    private let coordinator: ExchangeListCoordinating
    weak var controller: ExchangeListDisplaying?
    
    init(coordinator: ExchangeListCoordinating) {
        self.coordinator = coordinator
    }
    
    public func presentExchanges(exchanges: [Exchange], designSystem: DesignSystem) {
        let cells = exchanges.compactMap {
            let dto = DSExchangeCellDTO(title: $0.name, subtitle: $0.exchangeId, value: "$ \($0.volume1DayUsd)")
            let cell = designSystem.makeExchangeCell(style: .default)
            cell.updateCell(dto)
            return cell
        }
        controller?.displayExchanges(cells)
//        controller?.displayExchanges(exchanges)
    }
    
    public func presentExchanges(icons: [ExchangeIcon]) {
        
    }
    
    public func goToExchangeDetail() {
    }
}
