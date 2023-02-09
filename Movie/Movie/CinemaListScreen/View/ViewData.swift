// ViewData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация для экрана со списком фильмов.
enum ViewData {
    case initial
    case loading
    case success([Cinema])
}

/// Структура для передачи данных на экран подробностей о фильме.
struct Cinema {
    // Название фильма
    let title: String
    // Адрес постера фильма
    let imagePath: String
    // Описание фильма
    let modelOverview: String
    // Средняя оценка фильма
    let modelVoteAverage: Double
    // Количество оценок фильма
    let modelVoteCount: Int
}

/// Информация для экрана со списком фильмов.
enum ViewImageData {
    case initial
    case loading
    case success([String: Data])
}
