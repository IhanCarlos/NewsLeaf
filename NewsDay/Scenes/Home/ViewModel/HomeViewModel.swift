//
//  HomeViewModel.swift
//  NewsDay
//
//  Created by ihan carlos on 20/05/24.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate {
    func goToDetails(article: Article)
}

protocol HomeViewModelProtocol {
    
    var numberArticles: Int { get }
    var articles: [Article]? { get }
    var banner: [BannerArticle]? { get }
    var numberBanner: Int { get }
    
    func fetchHedlineNews()
    func fetchTopHedline()
    
    func observeStates(_ completion: @escaping (HomeViewState) -> Void)
    func filterItems(with searchText: String)
    
    func goToDetails(article: Article)
}

enum HomeViewState: Equatable {
    case loading
    case success
    case failure
    case reloadData
}

class HomeViewModel: HomeViewModelProtocol {
    
    private var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    private var service: HomeServiceProtocol
    private var state: Observable<HomeViewState> = Observable(.loading)
    
    public var articles: [Article]? = []
    private var dataArticles: [Article]? = [] {
        didSet {
            articles = dataArticles
        }
    }
    
    var banner: [BannerArticle]?
    var numberArticles: Int { articles?.count ?? 0 }
    var numberBanner: Int { banner?.count ?? 0 }
    
    init(delegate: HomeViewModelCoordinatorDelegate, service: HomeServiceProtocol = HomeService()) {
        self.coordinatorDelegate = delegate
        self.service = service
    }
    
    func goToDetails(article: Article) {
        coordinatorDelegate?.goToDetails(article: article)
    }
    
    func observeStates(_ completion: @escaping (HomeViewState) -> Void) {
        state.addObserver { completion($0) }
    }
    
    func fetchHedlineNews() {
        state.observedValue = .loading
        service.fetchHedlineNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataArticles = response.articles
                self.state.observedValue = .success
            case .failure(let error):
                self.dataArticles = nil
                self.state.observedValue = .failure
            }
        }
    }
    
    func fetchTopHedline() {
        service.fetchTopHedlineNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.banner = response.articles
                self.state.observedValue = .success
            case .failure(let error):
                self.state.observedValue = .failure
            }
        }
    }
    
    public func filterItems(with searchText: String) {
        if searchText.isEmpty {
            articles = dataArticles
        } else {
            articles = dataArticles?.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        state.observedValue = .reloadData
    }
}
