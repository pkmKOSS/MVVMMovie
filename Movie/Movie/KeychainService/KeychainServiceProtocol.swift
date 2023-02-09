// KeychainServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол работы с зашифрованными
protocol KeychainServiceProtocol {
    func updateAPI(key: String)
    func saveAPI(key: String)
    func decodeAPIKey() -> String
    func deleteAPIKey()
}
