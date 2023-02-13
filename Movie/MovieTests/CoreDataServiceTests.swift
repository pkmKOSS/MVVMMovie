// CoreDataServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты сервиса работы с локальной базой данных
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Private properties

    private var coreDataService: CoreDataServiceProtocol!

    // MARK: - Publoc methods

    override func teardown() {
        super.teardown()
        coreDataService = nil
    }

    override func setUpWithError() throws {
        super.setUp()
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
