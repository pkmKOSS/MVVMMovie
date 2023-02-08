// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конструктор экрана со списком фильмов
final class Builder: BuilderProtocol {
    // MARK: - Private properties

    private let networkManager = NetworkManager()
    private let imageAPIService = ImageAPIServiceImp()
    private let cacheService = CacheService()

    // MARK: - Public methods

    func buildCinemaListScreen() -> UIViewController {
        let proxy = ProxyImp(imageAPIService: imageAPIService, cacheService: cacheService)
        let imageService = ImageServiceImp(proxy: proxy)
        let viewModel = CinemaListScreenViewModelImp(networkManager: networkManager, imageService: imageService)
        let internalView = CinemaListInternalView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let viewController = CinemaListViewController()
        viewController.internalView = internalView
        viewController.viewModel = viewModel
        return viewController
    }

    func buildCinemaDescriptionScreen(cinema: Cinema) -> UIViewController {
        let proxy = ProxyImp(imageAPIService: imageAPIService, cacheService: cacheService)
        let imageService = ImageServiceImp(proxy: proxy)
        let viewModel = CinemaDescriptionViewModelImp(networkService: networkManager, imageService: imageService)
        let viewController = CinemaDescriptionViewController(cinema: cinema)
        viewController.viewModel = viewModel
        return viewController
    }
}
