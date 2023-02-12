// MockNetworkService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import UIKit

/// Моковый класс NetworkService
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private properties

    private var fakeApiKey = GlobalConstants.fakeApiKeyName
    private var fakeGetedCinema: Data?
    private var fakeImageData: Data?

    // MARK: - Public methods

    func sendRequest<T>(urlString: String, model: T.Type, completion: @escaping (Movie.GetPostResult) -> Void)
        where T: Decodable, T: Encodable { completion(GetPostResult.succes(cinema: fakeGetedCinema)) }

    func getCinema(typeOfRequest: Movie.TypeOfCinemaRequset, completion: @escaping (Movie.GetPostResult) -> Void) {
        let errorTemp = NSError(
            domain: GlobalConstants.defaultErrorText,
            code: GlobalConstants.defaultErrorCode,
            userInfo: nil
        )

        switch typeOfRequest {
        case .getUpcoming:
            fakeGetedCinema = Data()
            completion(GetPostResult.succes(cinema: fakeGetedCinema))
        case .getPopular:
            completion(GetPostResult.failure(cinema: errorTemp))
        case .getNew:
            fakeGetedCinema = Data()
            completion(GetPostResult.succes(cinema: fakeGetedCinema))
        }
    }

    func getImage(posterPath: String, size: Movie.SizeOfImages, completion: @escaping (Movie.GetImageResult) -> Void) {
        let errorTemp = NSError(
            domain: GlobalConstants.defaultErrorText,
            code: GlobalConstants.defaultErrorCode,
            userInfo: nil
        )

        guard
            posterPath == GlobalConstants.defaultImageName,
            let imageData = UIImage(named: GlobalConstants.defaultImageName)?.pngData()
        else {
            completion(GetImageResult.failure(cinema: errorTemp))
            return
        }
        fakeImageData = imageData
        completion(GetImageResult.succes(cinema: imageData))
    }

    func setKeyChainApi(key: String) {
        fakeApiKey = key
    }
}
