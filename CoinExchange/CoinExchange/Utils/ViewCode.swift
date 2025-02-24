import Foundation

public protocol ViewCode: AnyObject {
    func setupHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurations()
    func buildView()
}

public extension ViewCode {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
}
