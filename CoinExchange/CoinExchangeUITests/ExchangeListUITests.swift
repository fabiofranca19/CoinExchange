import XCTest

class ExchangeListUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testMainScreenLoadsExchangeList() {
        let exchangeListTable = app.tables["exchangeListTableView"]
        XCTAssertTrue(exchangeListTable.waitForExistence(timeout: 5), "A tabela de câmbios deve estar presente na tela principal")
        
        let firstCell = app.cells["exchangeCell_0"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "Pelo menos uma célula de câmbio deve ser carregada")
        
        XCTAssertTrue(firstCell.images["exchangeIconImageView"].exists, "O ícone da exchange deve estar presente")
        XCTAssertTrue(firstCell.staticTexts["exchangeNameLabel"].exists, "O nome da exchange deve estar presente")
    }
    
    func testNavigationToDetailScreen() {
        let exchangeListTable = app.tables["exchangeListTableView"]
        
        let firstCell = app.cells["exchangeCell_0"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "A primeira célula deve existir")
        
        let exchangeName = firstCell.staticTexts["exchangeNameLabel"].label
        firstCell.tap()
        
        let detailView = app.otherElements["exchangeDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5), "A tela de detalhes deve ser exibida após tocar em uma célula")
        
        XCTAssertTrue(detailView.staticTexts[exchangeName].exists, "O nome da exchange selecionada deve estar presente na tela de detalhes")
        XCTAssertTrue(detailView.staticTexts["exchangeIdLabel"].exists, "O ID da exchange deve estar presente na tela de detalhes")
        XCTAssertTrue(detailView.staticTexts["volume1DayLabel"].exists, "O volume diário deve estar presente na tela de detalhes")
    }
    
    func testExchangeCellContent() {
        let exchangeListTable = app.tables["exchangeListTableView"]
        let firstCell = app.cells["exchangeCell_0"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "A primeira célula deve existir")
        
        let iconImage = firstCell.images["exchangeIconImageView"]
        let nameLabel = firstCell.staticTexts["exchangeNameLabel"]
        let idLabel = firstCell.staticTexts["exchangeIdLabel"]
        
        XCTAssertTrue(iconImage.exists, "O ícone da exchange deve estar presente")
        XCTAssertFalse(nameLabel.label.isEmpty, "O nome da exchange não deve estar vazio")
        XCTAssertFalse(idLabel.label.isEmpty, "O ID da exchange não deve estar vazio")
    }
}
