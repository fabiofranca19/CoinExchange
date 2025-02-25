protocol ExchangeDetailPresenting: AnyObject {
}

final class ExchangeDetailPresenter {
    private let coordinator: ExchangeDetailCoordinating
    weak var viewController: ExchangeDetailDisplaying?

    init(coordinator: ExchangeDetailCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - ExchangeDetailPresenting
extension ExchangeDetailPresenter: ExchangeDetailPresenting {
}
