// CinemaListScreenViewModelTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты модели представления списка фильмов
final class CinemaListScreenViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var cinemaListScreenViewModel: CinemaListScreenViewModelProtocol!
    private var networkService: NetworkServiceProtocol!
    private var keychainService: KeychainServiceProtocol!
    private var coreDataService: CoreDataServiceProtocol!
    private var imageAPIService: ImageAPIServiceProtocol!
    private var cacheService: CacheServiceProtocol!
    private var proxy: Proxy!
    private var imageService: ImageServiceProtocol!

    // MARK: - Public methods

    override func teardown() {
        super.teardown()
        networkService = nil
        imageAPIService = nil
        cacheService = nil
        keychainService = nil
        coreDataService = nil
        proxy = nil
        imageService = nil
        cinemaListScreenViewModel = nil
    }

    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        imageAPIService = MockImageApiService()
        cacheService = MockCacheService()
        keychainService = MockKeychainService()
        coreDataService = MockCoreDataService()
        proxy = MockProxy(imageAPIService: imageAPIService, cacheService: cacheService)
        imageService = ImageService(proxy: proxy)

        cinemaListScreenViewModel = CinemaListScreenViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataService: coreDataService
        )

        cinemaListScreenViewModel.onUpcomingCinemaTapHandler = { _ in
            print(GlobalConstants.fooName)
        }

        cinemaListScreenViewModel.onPopulareCinemaTapHandler = { _ in
            print(GlobalConstants.fooName)
        }

        cinemaListScreenViewModel.onNewCinemaTapHandler = { _ in
            print(GlobalConstants.fooName)
        }

        cinemaListScreenViewModel.showErrorAlertHandler = { _ in
            print(GlobalConstants.fooName)
        }

        cinemaListScreenViewModel.showApiKeyAlertHandler = {
            print(GlobalConstants.fooName)
        }

        cinemaListScreenViewModel.fetchImageHandler = { _, _ in
            print(GlobalConstants.fooName)
        }
    }

    func testFetchCinema() throws {
        cinemaListScreenViewModel.fetchCinema(typeOfCinema: .getUpcoming)
        networkService.getCinema(typeOfRequest: .getUpcoming) { result in
            switch result {
            case let .succes(cinema):
                XCTAssertNotNil(cinema)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }

        networkService.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                XCTAssertNil(cinema)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testMakeCinemaLibrary() {
        let cinemaLibrary = InfoAboutCinema(results: [
            Result(
                adult: false,
                backdropPath: GlobalConstants.emptyString,
                genreIDS: [],
                id: 0,
                originalLanguage: GlobalConstants.emptyString,
                originalTitle: GlobalConstants.emptyString,
                overview: GlobalConstants.emptyString,
                popularity: 0.0,
                posterPath: GlobalConstants.emptyString,
                releaseDate: GlobalConstants.emptyString,
                title: GlobalConstants.emptyString,
                video: false,
                voteAverage: 0.0,
                voteCount: 0
            )
        ])
        let library = cinemaListScreenViewModel.makeCinemaLibrary(cinemaResponse: cinemaLibrary)
        XCTAssertNotNil(library)
    }

    func testSetKeyChainManual() throws {
        cinemaListScreenViewModel.setKeyChainManual(key: GlobalConstants.newFakeApiKeyName)
        let newKey = keychainService.decodeAPIKey()
        XCTAssertEqual(GlobalConstants.newFakeApiKeyName, newKey)
    }

    func testCheckKeychain() throws {
        let isKeychainSetSuccess = cinemaListScreenViewModel.checkKeychain()
        XCTAssertTrue(isKeychainSetSuccess)
    }

    func testCleanUserApiKey() throws {
        cinemaListScreenViewModel.cleanUserApiKey()
        let resultOfDeleting = keychainService.decodeAPIKey()
        XCTAssertEqual(resultOfDeleting, GlobalConstants.defaultDeletedApiKeyName)
    }
}
