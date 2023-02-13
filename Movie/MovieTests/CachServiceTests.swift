// CachServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты CachService
final class CachServiceTests: XCTestCase {
    // MARK: - Private properties

    private var cacheService: CacheServiceProtocol!

    // MARK: - Public methods

    override func teardown() {
        cacheService = nil
    }

    override func setUpWithError() throws {
        cacheService = CacheService()
    }

    func testSaveDataToCache() throws {
        let imageData = UIImage(named: GlobalConstants.defaultImageName)?.pngData() ?? Data()
        cacheService.saveDataToCache(
            fileURL: GlobalConstants.defaultImageName,
            data: imageData,
            cacheDataType: CacheDataType.images
        )

        let data = cacheService.loadDataFromCache(
            fileURL: GlobalConstants.defaultImageName,
            cacheDataType: CacheDataType.images
        )
        XCTAssertNotNil(data)
    }

    func testLoadDataFromCache() {
        let data = cacheService.loadDataFromCache(
            fileURL: GlobalConstants.emptyString,
            cacheDataType: CacheDataType.images
        )
        XCTAssertNil(data)
    }
}
