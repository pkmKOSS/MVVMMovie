// CinemaDescriptionViewModelImp.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

/// Вью модель экрана с подробностями о фильме
final class CinemaDescriptionViewModelImp: CinemaDescriptionViewModelProtocol {
    // MARK: - Public properties

    let networkService: NetworkService
    let imageService: ImageServiceProtocol

    // MARK: - Init

    init(
        networkService: NetworkService,
        imageService: ImageServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
    }
}
