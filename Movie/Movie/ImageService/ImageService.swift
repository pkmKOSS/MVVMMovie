// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервис загрузки изображений
protocol ImageService {
    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        complition: @escaping (GetImageResult) -> Void
    )
}
