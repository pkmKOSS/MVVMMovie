// AppDelegate.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import CoreData
import UIKit

@main
// Сгенерированный AppDelegate
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Public properties

    var keychainService = KeychainService()
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    static let sharedAppDelegate: AppDelegate = {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            fatalError("SharedAppDelegate не был создан")
        }
        return appDelegate
    }()

    // MARK: - Core Data stack

    lazy var defaultPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CinemaLibrary")
        container.loadPersistentStores { _, _ in }
        return container
    }()

    // MARK: - Public methods

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
        keychainService.deleteAPIKey()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        keychainService.deleteAPIKey()
    }
}
