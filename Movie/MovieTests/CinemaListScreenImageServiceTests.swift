// CinemaListScreenImageServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты CinemaListScreenImageServic
final class CinemaListScreenImageServiceTests: XCTestCase {
    // MARK: - Private properties

    private var imageService: ImageServiceProtocol!
    private var imageAPIService: ImageAPIServiceProtocol!
    private var cacheService: CacheServiceProtocol!
    private var proxy: Proxy!

    // MARK: - Public methods

    override func setUpWithError() throws {
        imageAPIService = MockImageApiService()
        cacheService = MockCacheService()
        proxy = MockProxy(imageAPIService: imageAPIService, cacheService: cacheService)
        imageService = ImageService(proxy: proxy)
    }

    func testGetImage() throws {
        let imageData = UIImage(named: GlobalConstants.defaultImageName)?.pngData() ?? Data()
        imageService.fetchImage(posterPath: GlobalConstants.defaultImageName, size: .w500) { result in
            switch result {
            case let .succes(image):
                XCTAssertEqual(imageData, image)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
}
