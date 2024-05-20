//
//  AppDelegate.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationCon = UINavigationController()
        appCoordinator = AppCoordinator(navCon: navigationCon)
        appCoordinator?.start()
        window?.rootViewController = navigationCon
        window?.makeKeyAndVisible()
        return true
    }
}
