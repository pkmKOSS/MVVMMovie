// NetworkServiceProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

protocol NetworkServiceProtocol {
    /// Запросить список кинофильмов.
    /// - Parameters:
    ///   - typeOfRequest: Тип запроса в зависимости от конкретных характеристик кинофильмов.
    ///   - handler: Возвращает массив кинофильмов или ошибку.
    func getCinema(typeOfRequest: TypeOfCinemaRequset, completion: @escaping (GetPostResult) -> Void)
    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - completion: Замыкание.
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (GetImageResult) -> Void
    )

    /// Метод устанавливает апи кей
    /// - Parameter key: ключ
    func setKeyChainApi(key: String)

    func sendRequest<T: Codable>(
        urlString: String,
        model: T.Type,
        completion: @escaping (GetPostResult) -> Void
    )
}
