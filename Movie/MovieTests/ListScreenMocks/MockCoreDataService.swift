// MockCoreDataService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation
@testable import Movie

/// Моковый класс CoreDataServic
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Private properties

    private var fakeCachedCoreData: [Cinema] = []

    // MARK: - Public methods

    func saveData(_ data: [Movie.Cinema]) {
        fakeCachedCoreData = data
    }

    func loadData() -> [Movie.Cinema] {
        fakeCachedCoreData
    }
}
