// BaseCoordinator.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Базовый координатор
class BaseCoordinator: BaseCoordinatorProtocol {
    // MARK: - Public properties

    var childCoordinators: [BaseCoordinatorProtocol] = []
    var isStarted: Bool = false

    // MARK: - Public methods

    func start() {
        isStarted.toggle()
    }

    func addDependency(_ coordinator: BaseCoordinatorProtocol) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinatorProtocol?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
