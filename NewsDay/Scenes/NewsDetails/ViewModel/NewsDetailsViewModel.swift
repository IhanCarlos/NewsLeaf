//
//  NewsDetailsViewModel.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import Foundation

protocol NewsDetailsViewModelCoordinatorDelegate {
    func backScreen()
}

protocol DetailsViewModelProtocol {
    func observeStates(_ completion: @escaping (DetailsViewState) -> Void)
}

enum DetailsViewState {
    case setupView(Article)
}

class NewsDetailsViewModel:DetailsViewModelProtocol {
    
    public var article: Article
    private var state: Observable<DetailsViewState>
    
    private var coordinatorDelegate: NewsDetailsViewModelCoordinatorDelegate?
    
    init(article: Article, coordinatorDelegate: NewsDetailsViewModelCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
        self.article = article
        self.state = .init(.setupView(article))
    }
    
    func backScreen() {
        coordinatorDelegate?.backScreen()
    }
    
    func observeStates(_ completion: @escaping (DetailsViewState) -> Void) {
        state.addObserver { completion($0) }
    }
}
