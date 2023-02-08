// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол прокси загрузки изображения
protocol Proxy {
    func fetch(posterPath: String, size: SizeOfImages, complition: @escaping (GetImageResult) -> Void)
}