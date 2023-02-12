// CinemaListScreenViewModelProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

///  Протокол работы вью модели экрана со списком фильмов
protocol CinemaListScreenViewModelProtocol {
    var onNewCinemaTapHandler: ((ViewData) -> ())? { get set }
    var onPopulareCinemaTapHandler: ((ViewData) -> ())? { get set }
    var onUpcomingCinemaTapHandler: ((ViewData) -> ())? { get set }
    var fetchImageHandler: ((String, Data) -> ())? { get set }
    var showErrorAlertHandler: ((String) -> Void)? { get set }
    var showApiKeyAlertHandler: (() -> ())? { get set }

    func setKeychain() -> Bool
    func cleanUserApiKey()
    func fetchCinema(typeOfCinema: TypeOfCinemaRequset)
}
