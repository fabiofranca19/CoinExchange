import Foundation

protocol ExchangeDetailServicing {
}

final class ExchangeDetailService {
    private let container: DependencyInjecting

    init(container: DependencyInjecting) {
        self.container = container
    }
}

// MARK: - ExchangeDetailServicing
extension ExchangeDetailService: ExchangeDetailServicing {
}
