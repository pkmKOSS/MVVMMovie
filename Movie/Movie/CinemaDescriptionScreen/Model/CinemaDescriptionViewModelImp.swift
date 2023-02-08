// CinemaDescriptionViewModelImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана с подробностями о фильме
final class CinemaDescriptionViewModelImp: CinemaDescriptionViewModel {
    // MARK: - Public properties

    let networkService: NetworkManager
    let imageService: ImageService

    // MARK: - Init

    init(
        networkService: NetworkManager,
        imageService: ImageService
    ) {
        self.networkService = networkService
        self.imageService = imageService
    }
}
