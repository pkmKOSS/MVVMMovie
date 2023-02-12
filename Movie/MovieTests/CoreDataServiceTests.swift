// CoreDataServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты CoreDataService
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Private properties

    private var coreDataService: CoreDataServiceProtocol!

    // MARK: - Publoc methods

    override func setUpWithError() throws {
        coreDataService = CoreDataService()
    }

    func testSaveData() throws {
        let fakeData = [
            Cinema(
                title: GlobalConstants.fooName,
                imagePath: GlobalConstants.fooName,
                modelOverview: GlobalConstants.fooName,
                modelVoteAverage: 0.0,
                modelVoteCount: 0
            )
        ]
        coreDataService.saveData(fakeData)
        let loadedData = coreDataService.loadData()
        XCTAssertNotEqual(loadedData.count, 0)
    }
}
