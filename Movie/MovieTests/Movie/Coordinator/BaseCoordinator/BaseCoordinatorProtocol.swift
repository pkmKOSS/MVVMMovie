// BaseCoordinatorProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Протокол основного координатора
protocol BaseCoordinatorProtocol: AnyObject {
    var childCoordinators: [BaseCoordinatorProtocol] { get set }
    var isStarted: Bool { get set }

    func start()
    func addDependency(_ coordinator: BaseCoordinatorProtocol)
    func removeDependency(_ coordinator: BaseCoordinatorProtocol?)
    func setAsRoot(_ controller: UIViewController)
}
