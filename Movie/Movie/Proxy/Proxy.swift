// Proxy.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

/// Протокол прокси загрузки изображения
protocol Proxy {
    func fetch(posterPath: String, size: SizeOfImages, completion: @escaping (GetImageResult) -> Void)
}
