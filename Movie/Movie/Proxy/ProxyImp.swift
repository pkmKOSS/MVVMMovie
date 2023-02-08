// ProxyImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси сервиса загрузки изображений
final class ProxyImp: Proxy {
    // MARK: - Private properties

    private let imageAPIService: ImageAPIService
    private let cacheService: CacheServiceProtocol

    // MARK: - init

    init(
        imageAPIService: ImageAPIService,
        cacheService: CacheServiceProtocol
    ) {
        self.imageAPIService = imageAPIService
        self.cacheService = cacheService
    }

    func fetch(posterPath: String, size: SizeOfImages, complition: @escaping (GetImageResult) -> Void) {
        guard
            let imageData = cacheService.loadDataFromCache(fileURL: posterPath, cacheDataType: .images)
        else {
            imageAPIService.getImage(posterPath: posterPath, size: .w500) { result in
                complition(result)
            }
            return
        }
        complition(GetImageResult.succes(cinema: imageData))
    }
}
