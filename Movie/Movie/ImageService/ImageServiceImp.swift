// ImageServiceImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис работы с изображениями
final class ImageServiceImp: ImageService {
    // MARK: - Private properties

    let proxy: Proxy

    // MARK: - Init

    init(proxy: Proxy) {
        self.proxy = proxy
    }

    // MARK: - Public methods

    func fetchImage(posterPath: String, size: SizeOfImages, complition: @escaping (GetImageResult) -> Void) {
        proxy.fetch(posterPath: posterPath, size: size) { result in
            complition(result)
        }
    }
}
