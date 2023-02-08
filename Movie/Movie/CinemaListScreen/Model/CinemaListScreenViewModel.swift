// CinemaListScreenViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Протокол работы вью модели экрана со списком фильмов
protocol CinemaListScreenViewModel {
    var onNewCinemaTapHandler: ((ViewData) -> ())? { get set }
    var onPopulareCinemaTapHandler: ((ViewData) -> ())? { get set }
    var onUpcomingCinemaTapHandler: ((ViewData) -> ())? { get set }
    var fetchImageHandler: ((String, Data) -> ())? { get set }
    func fetchCinema()
}
