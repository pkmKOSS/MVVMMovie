// CoreDataServiceProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import CoreData
import Foundation

/// Протокол работы с сервисом кор даты
protocol CoreDataServiceProtocol {
    func saveData(_ data: [Cinema])
    func loadData() -> [Cinema]
}
