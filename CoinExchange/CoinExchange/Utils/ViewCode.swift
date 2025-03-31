import Foundation

protocol ViewCode: AnyObject {
    func setupHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurations()
    func buildView()
}

extension ViewCode {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
}
