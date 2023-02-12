// NetworkServiceTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты NetworkService
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private properties

    private var networkSerive: NetworkServiceProtocol!

    // MARK: - Public methods

    override func setUpWithError() throws {
        networkSerive = NetworkService()
    }

    func testGetCinema() throws {
        networkSerive.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                let cinemaLibrary = (cinema as? CinemaInfoProtocol)?.results
                XCTAssertNotNil(cinemaLibrary)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }

        networkSerive.getCinema(typeOfRequest: .getUpcoming) { result in
            switch result {
            case let .succes(cinema):
                let cinemaLibrary = (cinema as? CinemaInfoProtocol)?.results
                XCTAssertNotNil(cinemaLibrary)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }

        networkSerive.getCinema(typeOfRequest: .getNew) { result in
            switch result {
            case let .succes(cinema):
                let cinemaLibrary = (cinema as? CinemaInfoProtocol)?.results
                XCTAssertNotNil(cinemaLibrary)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
    }

    func testSetKeyChainApi() throws {
        networkSerive.setKeyChainApi(key: GlobalConstants.apiKeyForTest)
        networkSerive.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                let cinemaLibrary = (cinema as? CinemaInfoProtocol)?.results
                XCTAssertNotNil(cinemaLibrary)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
    }

    func testGetImage() throws {
        networkSerive.getImage(posterPath: GlobalConstants.defaultImageName, size: .w500) { result in
            switch result {
            case let .succes(imageData):
                let image = UIImage(data: imageData)
                XCTAssertNotNil(imageData)
            case let .failure(erorr):
                XCTAssertNotNil(erorr)
            }
        }
    }

    func testNetworkService() throws {
        networkSerive.sendRequest(urlString: GlobalConstants.emptyString, model: InfoAboutCinema.self) { result in
            switch result {
            case let .succes(cinema):
                let cinemaLibrary = (cinema as? CinemaInfoProtocol)?.results
                XCTAssertNotNil(cinemaLibrary)
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
    }
}
