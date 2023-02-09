// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Конструктор экрана со списком фильмов
final class Builder: BuilderProtocol {
    // MARK: - Private properties

    private let networkService = NetworkService()
    private let imageAPIService = ImageAPIService()
    private let cacheService = CacheService()
    private let keychainService = KeychainService()
    private let coreDataService = CoreDataService()

    // MARK: - Public methods

    func buildCinemaListScreen() -> UIViewController {
        let proxy = ProxyImp(imageAPIService: imageAPIService, cacheService: cacheService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = CinemaListScreenViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataService: coreDataService
        )
        let internalView = CinemaListInternalView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let viewController = CinemaListViewController()
        viewController.internalView = internalView
        viewController.viewModel = viewModel
        return viewController
    }

    func buildCinemaDescriptionScreen(cinema: Cinema, imageData: Data) -> UIViewController {
        let proxy = ProxyImp(imageAPIService: imageAPIService, cacheService: cacheService)
        let imageService = ImageService(proxy: proxy)
        let viewModel = CinemaDescriptionViewModelImp(networkService: networkService, imageService: imageService)
        let viewController = CinemaDescriptionViewController(cinema: cinema, imageData: imageData)
        viewController.viewModel = viewModel
        return viewController
    }
}
