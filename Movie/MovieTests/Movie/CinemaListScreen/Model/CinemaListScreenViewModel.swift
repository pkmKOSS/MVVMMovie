// CinemaListScreenViewModel.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

// Вью модель экрана со списком фильмов
final class CinemaListScreenViewModel: CinemaListScreenViewModelProtocol {
    // MARK: - Public propeties

    var onNewCinemaTapHandler: NewCinemaTapHandler?
    var onPopulareCinemaTapHandler: PopulareCinemaTapHandler?
    var onUpcomingCinemaTapHandler: UpcomingCinemaHandler?
    var fetchImageHandler: FetchImageHandler?
    var showErrorAlertHandler: ShowErrorAlertHandler?
    var showApiKeyAlertHandler: (() -> ())?

    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol
    private let imageService: ImageServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let coreDataService: CoreDataServiceProtocol

    // MARK: - Init

    init(
        networkService: NetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keychainService: KeychainServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.keychainService = keychainService
        self.coreDataService = coreDataService
    }

    // MARK: - Public methods

    func fetchCinema(typeOfCinema: TypeOfCinemaRequset) {
        guard
            checkKeychain(),
            let getPopular = onPopulareCinemaTapHandler,
            let getNew = onNewCinemaTapHandler,
            let getUpcoming = onUpcomingCinemaTapHandler,
            let showError = showErrorAlertHandler
        else { return }
        networkService.getCinema(typeOfRequest: typeOfCinema) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .succes(cinemaResponse):
                if let cinemaLibrary = self.makeCinemaLibrary(cinemaResponse: cinemaResponse) {
                    switch typeOfCinema {
                    case .getUpcoming:
                        getUpcoming(ViewData.success(cinemaLibrary))
                    case .getPopular:
                        getPopular(ViewData.success(cinemaLibrary))
                    case .getNew:
                        getNew(ViewData.success(cinemaLibrary))
                    }
                }
            case let .failure(error):
                guard let error = error else { return }
                showError(error.localizedDescription)
                getUpcoming(ViewData.success(self.coreDataService.loadData()))
            }
        }
    }

    func makeCinemaLibrary(cinemaResponse: Codable) -> [Cinema]? {
        let cinemaLibrary = (cinemaResponse as? CinemaInfoProtocol)?.results.map { [weak self] cinema in
            self?.fetchImage(posterPath: cinema.posterPath, size: .w500) { [weak self] data in
                guard
                    let self = self,
                    let fetchImage = self.fetchImageHandler
                else { return }
                fetchImage(cinema.posterPath, data)
            }
            return Cinema(
                title: cinema.title,
                imagePath: cinema.posterPath,
                modelOverview: cinema.overview,
                modelVoteAverage: cinema.voteAverage,
                modelVoteCount: cinema.voteCount
            )
        }
        coreDataService.saveData(cinemaLibrary ?? [])
        return cinemaLibrary
    }

    func fetchImage(
        posterPath: String,
        size: SizeOfImages,
        completion: @escaping (Data) -> ()
    ) {
        guard
            let showError = showErrorAlertHandler
        else { return }
        imageService.fetchImage(posterPath: posterPath, size: size) { result in
            switch result {
            case let .success(cinema):
                completion(cinema)
            case let .failure(error):
                guard let error = error else { return }
                showError(error.localizedDescription)
            }
        }
    }

    func checkKeychain() -> Bool {
        let key = keychainService.decodeAPIKey()
        guard let apiAlertHandler = showApiKeyAlertHandler else { return false }
        guard
            !keychainService.decodeAPIKey().isEmpty
        else {
            apiAlertHandler()
            return false
        }
        networkService.setKeyChainApi(key: key)
        return true
    }

    func setKeyChainManual(key: String) {
        networkService.setKeyChainApi(key: key)
        keychainService.saveAPI(key: key)
        fetchCinema(typeOfCinema: .getPopular)
    }

    func cleanUserApiKey() {
        keychainService.deleteAPIKey()
    }
}
