// ProxyImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси сервиса загрузки изображений
final class ProxyImp: Proxy {
    // MARK: - Private properties

    private let imageAPIService: ImageAPIServiceProtocol
    private let cacheService: CacheServiceProtocol

    // MARK: - init

    init(
        imageAPIService: ImageAPIServiceProtocol,
        cacheService: CacheServiceProtocol
    ) {
        self.imageAPIService = imageAPIService
        self.cacheService = cacheService
    }

    // MARK: - Public methods

    func fetch(posterPath: String, size: SizeOfImages, completion: @escaping (GetImageResult) -> Void) {
        guard
            let imageData = cacheService.loadDataFromCache(fileURL: posterPath, cacheDataType: .images)
        else {
            imageAPIService.getImage(posterPath: posterPath, size: .w500) { result in
                completion(result)
            }
            return
        }
        completion(GetImageResult.succes(cinema: imageData))
    }
}
