//
//  HomeUITests.swift
//  NewsDayUITests
//
//  Created by ihan carlos on 19/05/24.
//

import XCTest
@testable import NewsDay

class HomeViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testElementsExist() {
        let loadingIndicator = app.activityIndicators["loadingIndicator"]
        let searchBar = app.textFields["searchBar"]
        let newsTableView = app.tables["newsTableView"]
        let bannerNews = app.otherElements["bannerNews"]
        
        XCTAssertFalse(loadingIndicator.exists, "O indicador de carregamento não deve existir")
        XCTAssertTrue(searchBar.exists, "A barra de pesquisa deve existir")
        XCTAssertTrue(newsTableView.exists, "A tabela de notícias deve existir")
        XCTAssertTrue(bannerNews.exists, "O banner de notícias deve existir")
    }

    func testSearchBarInteraction() {
        let searchBar = app.textFields["searchBar"]
        XCTAssertTrue(searchBar.exists, "A barra de pesquisa deve existir")
        searchBar.tap()
        searchBar.typeText("Breaking News")
        XCTAssertEqual(searchBar.value as? String, "Breaking News", "O texto da barra de pesquisa deve ser 'Breaking News'")
    }
    
    func testTableViewInteraction() {
        let newsTableView = app.tables["newsTableView"]
        XCTAssertTrue(newsTableView.waitForExistence(timeout: 10), "A tabela de notícias deve existir")
        
        let firstCell = newsTableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "A primeira célula da tabela deve existir")
        
        firstCell.tap()
    }
}

