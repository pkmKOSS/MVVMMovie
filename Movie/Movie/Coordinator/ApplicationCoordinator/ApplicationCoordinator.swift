// ApplicationCoordinator.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Координатор навигации в приложении
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties

    private var builder: BuilderProtocol
    private var navigationController: UINavigationController?

    // MARK: - Init

    init(
        navigationController: UINavigationController? = nil,
        builder: BuilderProtocol
    ) {
        self.navigationController = navigationController
        self.builder = builder
    }

    // MARK: - Public methods

    override func start() {
        showCinemaListScreen()
    }

    // MARK: - Private methods

    private func showCinemaListScreen() {
        guard let controller = builder.buildCinemaListScreen() as? CinemaListViewController else { return }
        controller.toDescriptionScreen = { [weak self] cinema, data in
            guard let self = self else { return }
            self.showCinemaDescriptionScreen(cinema: cinema, imageData: data)
        }
        navigationController?.pushViewController(controller, animated: true)
        setAsRoot(navigationController ?? UINavigationController())
    }

    private func showCinemaDescriptionScreen(cinema: Cinema, imageData: Data) {
        let detailController = builder.buildCinemaDescriptionScreen(cinema: cinema, imageData: imageData)
        navigationController?.pushViewController(detailController, animated: true)
    }
}
