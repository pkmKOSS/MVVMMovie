// MockCoordinator.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import UIKit

/// Моковый класс Coordinator
final class MockCoordinator: BaseCoordinatorProtocol {
    // MARK: - Public properties

    var childCoordinators: [Movie.BaseCoordinatorProtocol] = []
    var isStarted: Bool = false

    // MARK: - Public methods

    func start() {
        isStarted.toggle()
    }

    func addDependency(_ coordinator: Movie.BaseCoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Movie.BaseCoordinatorProtocol?) {
        childCoordinators.removeAll()
    }

    func setAsRoot(_ controller: UIViewController) {}
}
