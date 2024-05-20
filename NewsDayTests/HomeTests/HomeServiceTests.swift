//
//  HomeTests.swift
//  NewsDayTests
//
//  Created by ihan carlos on 14/05/24.
//

import XCTest
@testable import NewsDay

class MockHomeService: HomeServiceProtocol {
    var fetchHeadlineNewsResult: Result<NewsResponse, APIError>?
    var fetchTopHeadlineNewsResult: Result<BannerResponse, APIError>?

    func fetchHedlineNews(completion: @escaping (Result<NewsResponse, APIError>) -> Void) {
        if let result = fetchHeadlineNewsResult {
            completion(result)
        }
    }

    func fetchTopHedlineNews(completion: @escaping (Result<BannerResponse, APIError>) -> Void) {
        if let result = fetchTopHeadlineNewsResult {
            completion(result)
        }
    }
}

class HomeViewModelTests: XCTestCase {
    var mockService: MockHomeService!
    var viewModel: HomeViewModel!
    var mockDelegate: MockHomeViewModelCoordinatorDelegate!

    override func setUp() {
        super.setUp()
        mockService = MockHomeService()
        mockDelegate = MockHomeViewModelCoordinatorDelegate()
        viewModel = HomeViewModel(delegate: mockDelegate, service: mockService)
    }

    func testFetchHeadlineNewsSuccess() {

        let articles = [Article(source: Source(id: "1", name: "Source 1"),
                                author: "Author 1",
                                title: "Title 1",
                                description: "Description 1",
                                url: "url1",
                                urlToImage: "urlToImage1",
                                publishedAt: "09/09/09",
                                content: "content1")]
        let newsResponse = NewsResponse(status: "ok", totalResults: 1, articles: articles)
        mockService.fetchHeadlineNewsResult = .success(newsResponse)

        let expectation = self.expectation(description: "Fetch headline news success")

        viewModel.observeStates { state in
            if state == .success {
                expectation.fulfill()
            }
        }

        viewModel.fetchHedlineNews()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(viewModel.articles?.count, 1)
        XCTAssertEqual(viewModel.articles?.first?.title, "Title 1")
    }

    func testFetchHeadlineNewsFailure() {

        mockService.fetchHeadlineNewsResult = .failure(.invalidData)

        let expectation = self.expectation(description: "Fetch headline news failure")

        viewModel.observeStates { state in
            if state == .failure {
                expectation.fulfill()
            }
        }

        viewModel.fetchHedlineNews()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(viewModel.articles)
    }

    func testFetchTopHeadlineSuccess() {
        
        let bannerArticles = [BannerArticle(source: Source(id: "1", name: "Source 1"),
                                            author: "Author 1",
                                            title: "Title 1",
                                            description: "Description 1",
                                            url: "url1",
                                            urlToImage: "urlToImage1",
                                            publishedAt: "09/09/09",
                                            content: "content1")]
        let bannerResponse = BannerResponse(status: "ok", totalResults: 1, articles: bannerArticles)
        mockService.fetchTopHeadlineNewsResult = .success(bannerResponse)

        let expectation = self.expectation(description: "Fetch top headline news success")

        viewModel.observeStates { state in
            if state == .success {
                expectation.fulfill()
            }
        }

        viewModel.fetchTopHedline()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(viewModel.banner?.count, 1)
        XCTAssertEqual(viewModel.banner?.first?.title, "Title 1")
    }

    func testFetchTopHeadlineFailure() {

        mockService.fetchTopHeadlineNewsResult = .failure(.invalidData)

        let expectation = self.expectation(description: "Fetch top headline news failure")

        viewModel.observeStates { state in
            if state == .failure {
                expectation.fulfill()
            }
        }

        viewModel.fetchTopHedline()

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(viewModel.banner)
    }
}

class MockHomeViewModelCoordinatorDelegate: HomeViewModelCoordinatorDelegate {
    var didGoToDetails = false

    func goToDetails(article: Article) {
        didGoToDetails = true
    }
}
