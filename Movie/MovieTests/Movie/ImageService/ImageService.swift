// ImageService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

/// Протокол сервис загрузки изображений
protocol ImageServiceProtocol {
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
