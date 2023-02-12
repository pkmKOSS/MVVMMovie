// NetworkService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

/// Менеджер для работы с сетью.
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Private properties

    private let shared = URLSession.shared
    private let decoder = JSONDecoder()
    private var apiKey: String?

    // MARK: - Init

    init() {}

    func setKeyChainApi(key: String) {
        apiKey = key
    }

    /// Запросить список кинофильмов.
    /// - Parameters:
    ///   - typeOfRequest: Тип запроса в зависимости от конкретных характеристик кинофильмов.
    ///   - handler: Возвращает массив кинофильмов или ошибку.
    func getCinema(typeOfRequest: TypeOfCinemaRequset, completion: @escaping (GetPostResult) -> Void) {
        switch typeOfRequest {
        case .getUpcoming:
            sendRequest(
                urlString: "\(URLStrings.getUpcoming.rawValue)\(apiKey ?? "")\(PageString.getUpcoming.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                completion(result)
            }
        case .getPopular:
            sendRequest(
                urlString: "\(URLStrings.getPopular.rawValue)\(apiKey ?? "")\(PageString.getPopular.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                completion(result)
            }
        case .getNew:
            sendRequest(
                urlString: "\(URLStrings.getNew.rawValue)\(apiKey ?? "")\(PageString.getNew.rawValue)",
                model: InfoAboutCinema.self
            ) { result in
                completion(result)
            }
        }
    }

    /// Получить постер фильма.
    /// - Parameters:
    ///   - posterPath: адрес изображение. Получается как поле Result
    ///   - size: Размер изображения.
    ///   - completion: Замыкание.
    func getImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (GetImageResult) -> Void
    ) {
        let urlString = "\(StringConstants.imageBaseUrl)\(size.rawValue)\(posterPath)"
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let result = GetImageResult.succes(cinema: data)
                completion(result)
            } else if let error = error {
                let result = GetImageResult.failure(cinema: error)
                completion(result)
            }
        }.resume()
    }

    func sendRequest<T: Codable>(
        urlString: String,
        model: T.Type,
        completion: @escaping (GetPostResult) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard
                let self = self,
                let cinematics = try? self.decoder.decode(model.self, from: data ?? Data())
            else { return }
            let result = GetPostResult.succes(cinema: cinematics)

            completion(result)

            if let error = error {
                completion(GetPostResult.failure(cinema: error))
            }
        }.resume()
    }
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetPostResult {
    case succes(cinema: Codable)
    case failure(cinema: Error?)
}

/// Результат обращения к веб сервису с кинофильмами.
enum GetImageResult {
    case succes(cinema: Data)
    case failure(cinema: Error?)
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
        "https://api.themoviedb.org/3/movie/upcoming?api_key="
    case getPopular =
        "https://api.themoviedb.org/3/movie/popular?api_key="
    case getNew = "https://api.themoviedb.org/3/movie/latest?api_key="
}

/// Часть ссылки со страницей и языком
enum PageString: String {
    case getUpcoming = "&language=ru&page-1"
    case getPopular = "&language=ru&page-2"
    case getNew = "&language=ru&page-3"
}
