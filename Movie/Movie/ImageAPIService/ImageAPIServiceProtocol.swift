// ImageAPIServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Сервис для получения фото
protocol ImageAPIService {
    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - complition: Замыкание.
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        complition: @escaping (GetImageResult) -> Void
    )
}
