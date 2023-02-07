// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Менеджер для работы с сетью.
final class NetworkManager {
    static let manager = NetworkManager()

    private init() {}

    private let shared = URLSession.shared
    private let decoder = JSONDecoder()

    /// Запросить список кинофильмов.
    /// - Parameters:
    ///   - typeOfRequest: Тип запроса в зависимости от конкретных характеристик кинофильмов.
    ///   - handler: Возвращает массив кинофильмов или ошибку.
    func getCinema(typeOfRequest: TypeOfCinemaRequset, complition: @escaping (GetPostResult) -> Void) {
        switch typeOfRequest {
        case .getUpcoming:
            sendRequest(
                urlString: URLStrings.getUpcoming.rawValue,
                model: InfoAboutCinema.self
            ) { result in
                complition(result)
            }
        case .getPopular:
            sendRequest(
                urlString: URLStrings.getPopular.rawValue,
                model: InfoAboutPopularCinema.self
            ) { result in
                complition(result)
            }
        case .getNew:
            sendRequest(
                urlString: URLStrings.getNew.rawValue,
                model: InfoAboutCinema.self
            ) { result in
                complition(result)
            }
        }
    }

    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - complition: Замыкание.
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        complition: @escaping (GetImageResult) -> Void
    ) {
        let urlString = "\(StringConstants.imageBaseUrl)\(size.rawValue)\(posterPath)"
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let result = GetImageResult.succes(cinema: data)
                complition(result)
            } else if let error = error {
                let result = GetImageResult.failure(cinema: error)
                complition(result)
            }
        }.resume()
    }

    private func sendRequest<T: Codable>(
        urlString: String,
        model: T.Type,
        complition: @escaping (GetPostResult) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let cinematics = try? JSONDecoder().decode(model.self, from: data ?? Data()) else { return }
            let result = GetPostResult.succes(cinema: cinematics)

            complition(result)

            if let error = error {
                complition(GetPostResult.failure(cinema: error))
            }
        }.resume()
    }
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetPostResult {
    case succes(cinema: Codable)
    case failure(cinema: Error)
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetImageResult {
    case succes(cinema: Data)
    case failure(cinema: Error)
}

/// Типы запроса в зависимости от получаемого контента.
enum TypeOfCinemaRequset {
    /// Получить список приближающихся релизов.
    case getUpcoming
    /// Получить список популярных картин.
    case getPopular
    /// Получить список новинок.
    case getNew
}

/// Размеры загружаемых изображений.
enum SizeOfImages: String {
    case w500
    case original
}

/// Ссылки для запросов.
enum URLStrings: String {
    case getUpcoming =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=ru&page-1"
    case getPopular =
        "https://api.themoviedb.org/3/movie/popular?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=ru&page-2"
    case getNew = "https://api.themoviedb.org/3/movie/latest?c7f7d1dc5a6aa58fd2f3602748ad9c64&language=ru&page-3"
}
