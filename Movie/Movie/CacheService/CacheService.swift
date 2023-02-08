// CacheService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для кэширования данных.
final class CacheService: CacheServiceProtocol {
    // MARK: - Private constants

    private enum Constants {
        static let slashName = "/"
    }

    // MARK: - Private properties

    private var cacheStorageMap: [String: Data] = [:]

    // MARK: - Public methods

    /// Сохранение данных в кеш.
    /// - Parameters:
    ///   - fileURL: URL объекта. Используется для присвоения имени локальному файлу.
    ///   - data: Экземпляр Data
    ///   - cashDataType: Тип, который был источником Data. Влияет на директорию размещения файла.
    func saveDataToCache(fileURL: String, data: Data, cacheDataType: CacheDataType) {
        guard
            let path = getDirectoryPath(cacheDataType: cacheDataType),
            let fileName = fileURL.split(separator: Character(Constants.slashName)).last
        else { return }
        let filePath = "\(path)/\(fileName)"
        FileManager.default.createFile(atPath: filePath, contents: data)
        cacheStorageMap[String(fileName)] = data
    }

    /// Загрузка данных из кеша.
    /// - Parameters:
    ///   - fileURL: URL объекта. Используется для поиска файла.
    ///   - cashDataType: Тип, который был источником Data. Влияет на директорию размещения файла.
    ///   - completion: Возвращает экземпляр класса Result<Data, Swift.Error>).
    func loadDataFromCache(
        fileURL: String,
        cacheDataType: CacheDataType
    ) -> Data? {
        guard
            let directoryPath = getDirectoryPath(cacheDataType: cacheDataType),
            let fileName = fileURL.split(separator: Character(Constants.slashName)).last
        else { return nil }

        if let cashedData = cacheStorageMap[String(fileName)] {
            return cashedData
        } else {
            let url = URL(fileURLWithPath: "\(directoryPath)/\(fileName)")

            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                return nil
            }
        }
    }

    // MARK: - Private methods

    private func getDirectoryPath(cacheDataType: CacheDataType) -> String? {
        let directory = {
            switch cacheDataType {
            case .images:
                return FileManager.SearchPathDirectory.cachesDirectory
            }
        }()

        guard
            let cacheDirectory = FileManager.default.urls(for: directory, in: .userDomainMask).first
        else { return nil }
        let url = cacheDirectory.appendingPathComponent(cacheDataType.rawValue, isDirectory: true)

        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        return cacheDirectory.appendingPathComponent(cacheDataType.rawValue, isDirectory: true).path
    }
}

/// Типы данных конвертируемых  Data
enum CacheDataType: String {
    case images = "Images"
}
