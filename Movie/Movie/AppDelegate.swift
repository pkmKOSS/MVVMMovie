// AppDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

@main
// Сгенерированный AppDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let navController = UINavigationController()
        let builder = Builder()
        coordinator = ApplicationCoordinator(navigationController: navController, builder: builder)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        coordinator?.start()
        return true
    }
}
