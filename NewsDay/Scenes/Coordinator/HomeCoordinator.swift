//
//  HomeCoordinator.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import UIKit

protocol HomeCoordinatorDelegate {}

class HomeCoordinator: BaseCoordinator {

    var navigationController: UINavigationController
    var delegate: HomeCoordinatorDelegate?
    init(navCon: UINavigationController, delegate: HomeCoordinatorDelegate) {
        self.navigationController = navCon
        self.delegate = delegate
    }

    override func start() {
        showHomeScreen()
    }

    func popViewController() {
        navigationController.popViewController(animated: true)
    }

    func showHomeScreen() {
        let viewModel = HomeViewModel(delegate: self)
        let viewController: HomeViewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showNewsDetailsScreen(article: Article) {
        let viewModel = NewsDetailsViewModel(article: article, coordinatorDelegate: self)
        let viewController: NewsDetailsViewController = NewsDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    
    func goToDetails(article: Article) {
        showNewsDetailsScreen(article: article)
    }
}

extension HomeCoordinator: NewsDetailsViewModelCoordinatorDelegate {
    func backScreen() {
        popViewController()
    }
}
