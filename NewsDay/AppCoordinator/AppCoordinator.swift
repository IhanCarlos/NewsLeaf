//
//  AppCoordinator.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    override func start() {
        goToLoginPage()
        navigationController.isNavigationBarHidden = true
    }
    func goToLoginPage() {
        let homeCoordinator = HomeCoordinator(
        navCon: navigationController,
        delegate: self
        )
        addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
    }
}

extension AppCoordinator: HomeCoordinatorDelegate { }
