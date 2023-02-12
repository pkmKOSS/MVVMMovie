// MockCacheService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation
@testable import Movie

// Моковый класс CacheService
final class MockCacheService: CacheServiceProtocol {
    // MARK: - Private properties

    private var cachedDataMap: [String: Data] = [:]

    // MARK: - Public methods

    func saveDataToCache(fileURL: String, data: Data, cacheDataType: Movie.CacheDataType) {
        cachedDataMap[fileURL] = data
    }

    func loadDataFromCache(fileURL: String, cacheDataType: Movie.CacheDataType) -> Data? {
        cachedDataMap[fileURL]
    }
}
