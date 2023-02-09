// ImageServiceImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис работы с изображениями
final class ImageService: ImageServiceProtocol {
    // MARK: - Private properties

    private let proxy: Proxy

    // MARK: - Init

    init(proxy: Proxy) {
        self.proxy = proxy
    }

    // MARK: - Public methods

    func fetchImage(posterPath: String, size: SizeOfImages, completion: @escaping (GetImageResult) -> Void) {
        proxy.fetch(posterPath: posterPath, size: size) { result in
            completion(result)
        }
    }
}
