import UIKit
@testable import CoinExchange

final class DesignSystemMock: DesignSystem {
    public enum Message: AutoEquatable {
        case makeLoading
        case makeExchangeCell(style: UITableViewCell.CellStyle)
        case makeErrorView
    }
    
    private(set) var messages: [Message] = []
    
    let mockLoadingView = LoadingViewMock()
    let mockExchangeCell = ExchangeCellMock(style: .default, reuseIdentifier: nil)
    let mockErrorView = ErrorViewMock()
    
    func makeLoading() -> LoadingViewDisplaying {
        messages.append(.makeLoading)
        return mockLoadingView
    }
    
    func makeExchangeCell(style: UITableViewCell.CellStyle) -> DSExchangeCellDisplaying {
        messages.append(.makeExchangeCell(style: style))
        return mockExchangeCell
    }
    
    func makeErrorView() -> ErrorViewDisplaying {
        messages.append(.makeErrorView)
        return mockErrorView
    }
}

final class LoadingViewMock: UIView, LoadingViewDisplaying {
    public enum Message: AutoEquatable {
        case startAnimating
        case stopAnimating
    }
    
    private(set) var messages: [Message] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        messages.append(.startAnimating)
    }
    
    func stopAnimating() {
        messages.append(.stopAnimating)
    }
}

final class ExchangeCellMock: UITableViewCell, DSExchangeCellDisplaying {
    public enum Message: AutoEquatable {
        case updateCell(dto: DSExchangeCellDTO)
        case updateImage(icon: UIImage?)
    }
    
    private(set) var messages: [Message] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(_ dto: DSExchangeCellDTO) {
        messages.append(.updateCell(dto: dto))
    }
    
    func updateImage(_ icon: UIImage?) {
        messages.append(.updateImage(icon: icon))
    }
}

final class ErrorViewMock: UIView, ErrorViewDisplaying {
    public enum Message: AutoEquatable {
        case showError(message: String, designSystem: DesignSystem?)
        case hideError
    }
    
    private(set) var messages: [Message] = []
    
    var onRetry: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(message: String, designSystem: DesignSystem?) {
        messages.append(.showError(message: message, designSystem: designSystem))
    }
    
    func hideError() {
        messages.append(.hideError)
    }
    
    func simulateRetry() {
        onRetry?()
    }
}
