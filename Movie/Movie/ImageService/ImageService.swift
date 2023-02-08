// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервис загрузки изображений
protocol ImageService {
    /// Метод получения изображения
    /// - Parameters:
    ///   - posterPath: Адрес постера
    ///   - size: размер постера
    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (GetImageResult) -> Void
    )
}
