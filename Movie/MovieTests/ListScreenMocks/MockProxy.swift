// MockProxy.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie

/// Моковый класс Proxy
final class MockProxy: Proxy {
    // MARK: - Private properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let cacheService: CacheServiceProtocol
    private let validFakePosterPath = GlobalConstants.defaultImageName

    // MARK: - init

    init(
        imageAPIService: ImageAPIServiceProtocol,
        cacheService: CacheServiceProtocol
    ) {
        self.imageAPIService = imageAPIService
        self.cacheService = cacheService
    }

    // MARK: - Public methods

    func fetch(posterPath: String, size: Movie.SizeOfImages, completion: @escaping (Movie.GetImageResult) -> Void) {
        if posterPath == validFakePosterPath {
            imageAPIService.getImage(posterPath: posterPath, size: .w500) { result in
                completion(result)
            }
        } else {
            guard
                let imageData = cacheService.loadDataFromCache(fileURL: posterPath, cacheDataType: .images)
            else { return }
            completion(GetImageResult.succes(cinema: imageData))
        }
    }
}
