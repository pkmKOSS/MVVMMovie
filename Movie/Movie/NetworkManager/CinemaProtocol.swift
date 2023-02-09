// CinemaProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол ответов на запрос фильмов конкретного типа
protocol CinemaInfoProtocol {
    var results: [Result] { get set }
}
