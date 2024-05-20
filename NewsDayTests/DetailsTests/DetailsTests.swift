//
//  DetailsTests.swift
//  NewsDayTests
//
//  Created by ihan carlos on 19/05/24.
//

import XCTest
import Foundation
@testable import NewsDay

class NewsDetailsViewModelTests: XCTestCase {
    
    var viewModel: NewsDetailsViewModel!
    var mockCoordinator: MockNewsDetailsViewModelCoordinatorDelegate!
    var article: Article!
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockNewsDetailsViewModelCoordinatorDelegate()
        article = Article(source: Source(id: "1", name: "Source Name"),
                          author: "Author",
                          title: "Title",
                          description: "Description",
                          url: "url",
                          urlToImage: "urlToImage",
                          publishedAt: "09/09/09",
                          content: "Content")
        viewModel = NewsDetailsViewModel(article: article, coordinatorDelegate: mockCoordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        article = nil
        super.tearDown()
    }
    
    func testObserveStates() {
        let expectation = self.expectation(description: "State is setupView with article")
        
        viewModel.observeStates { state in
            switch state {
            case .setupView(let receivedArticle):
                XCTAssertEqual(receivedArticle.title, self.article.title)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testBackScreen() {
        viewModel.backScreen()
        XCTAssertTrue(mockCoordinator.backScreenCalled, "The backScreen method should have been called on the coordinator delegate")
    }
}

class MockNewsDetailsViewModelCoordinatorDelegate: NewsDetailsViewModelCoordinatorDelegate {
    var backScreenCalled = false
    
    func backScreen() {
        backScreenCalled = true
    }
}
