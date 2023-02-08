// NetworkModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Даты выхода грядущего релиза.
struct Dates: Codable {
    let maximum, minimum: String
}

/// Сведения о грядущих новинках.
struct InfoAboutCinema: Codable, CinemaInfoProtocol {
    /// Массив с результатами запроса (фильмами)
    var results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

/// Сведения о конкретном фильме.
struct Result: Codable {
    /// Любительский ли фильм
    let adult: Bool
    /// Адрес фонового изображения
    let backdropPath: String
    /// ID жанра
    let genreIDS: [Int]
    /// ID фильма
    let id: Int
    /// Язык оригинала, название на оригинальном языке, описание
    let originalLanguage, originalTitle, overview: String
    /// Количество просмотров
    let popularity: Double
    /// Адрес постера, дата релиза, название
    let posterPath, releaseDate, title: String
    /// Трейлер
    let video: Bool
    /// Средняя оценка
    let voteAverage: Double
    /// Количество голосов
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
