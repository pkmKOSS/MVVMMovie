// ImageAPIServiceProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

// Сервис для получения фото
protocol ImageAPIServiceProtocol {
    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - completion: Замыкание.
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (GetImageResult) -> Void
    )
}
