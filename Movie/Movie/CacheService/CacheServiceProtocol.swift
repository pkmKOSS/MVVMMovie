// CacheServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол кеширования данных
protocol CacheServiceProtocol {
    func saveDataToCache(fileURL: String, data: Data, cacheDataType: CacheDataType)
    func loadDataFromCache(
        fileURL: String,
        cacheDataType: CacheDataType
    ) -> Data?
}
