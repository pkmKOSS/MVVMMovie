// CinemaListScreenViewModelImp.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Вью модель экрана со списком фильмов
final class CinemaListScreenViewModel: CinemaListScreenViewModelProtocol {
    // MARK: - Public propeties

    var onNewCinemaTapHandler: ((ViewData) -> ())?
    var onPopulareCinemaTapHandler: ((ViewData) -> ())?
    var onUpcomingCinemaTapHandler: ((ViewData) -> ())?
    var fetchImageHandler: ((String, Data) -> ())?
    var showErrorAlertHandler: ((String) -> Void)?

    // MARK: - Private properties

    private let networkManager: NetworkServiceProtocol
    private let imageService: ImageServiceProtocol

    // MARK: - Init

    init(
        networkManager: NetworkServiceProtocol,
        imageService: ImageServiceProtocol
    ) {
        self.networkManager = networkManager
        self.imageService = imageService
    }

    // MARK: - Public methods

    func fetchCinema(typeOfCinema: TypeOfCinemaRequset) {
        guard
            let getPopular = onPopulareCinemaTapHandler,
            let getNew = onNewCinemaTapHandler,
            let getUpcoming = onUpcomingCinemaTapHandler,
            let showError = showErrorAlertHandler
        else { return }
        networkManager.getCinema(typeOfRequest: typeOfCinema) { [weak self] result in
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
                    showError(error.localizedDescription)
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
                case let .succes(cinema):
                    completion(cinema)
                case let .failure(error):
                    showError(error.localizedDescription)
            }
        }
    }
}
