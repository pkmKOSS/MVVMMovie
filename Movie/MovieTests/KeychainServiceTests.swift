// KeychainServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты  сервиса работы с зашифрованной информацией
final class KeychainServiceTests: XCTestCase {
    // MARK: - Private properties

    private var keychainService: KeychainServiceProtocol!

    // MARK: - Public methods

    override func teardown() {
        super.teardown()
        keychainService.deleteAPIKey()
        keychainService = nil
    }

    override func setUpWithError() throws {
        super.setUp()
        keychainService = KeychainService()
    }

    func testSaveAPI() {
        keychainService.saveAPI(key: GlobalConstants.someAPIKeyName)
        let oldKey = keychainService.decodeAPIKey()
        XCTAssertEqual(oldKey, GlobalConstants.someAPIKeyName)
    }

    func testUpdateAPIKey() {
        keychainService.saveAPI(key: GlobalConstants.someAPIKeyName)
        let oldKey = keychainService.decodeAPIKey()
        XCTAssertEqual(oldKey, GlobalConstants.someAPIKeyName)
        keychainService.updateAPI(key: GlobalConstants.someNewAPIKeyNam)
        let newKey = keychainService.decodeAPIKey()
        XCTAssertEqual(newKey, GlobalConstants.someNewAPIKeyNam)
    }

    func testDecodeAPIKey() {
        keychainService.saveAPI(key: GlobalConstants.someAPIKeyName)
        let key = keychainService.decodeAPIKey()
        XCTAssertEqual(key, GlobalConstants.someAPIKeyName)
    }

    func testDeleteKey() {
        keychainService.saveAPI(key: GlobalConstants.someAPIKeyName)
        keychainService.deleteAPIKey()
        let key = keychainService.decodeAPIKey()
        XCTAssertNotEqual(key, GlobalConstants.someAPIKeyName)
    }
}
