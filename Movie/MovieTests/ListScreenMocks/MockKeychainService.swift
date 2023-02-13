// MockKeychainService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie

/// Моковый класс KeychainService
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Private properties

    private var fakeKey: String? = GlobalConstants.internalfakeApiKeyName

    // MARK: - Public methods

    func updateAPI(key: String) {
        fakeKey = key
    }

    func saveAPI(key: String) {
        fakeKey = key
    }

    func decodeAPIKey() -> String {
        fakeKey ?? GlobalConstants.defaultDeletedApiKeyName
    }

    func deleteAPIKey() {
        fakeKey = nil
    }
}
