// MockImageApiService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import UIKit

// Моковый класс ImageApiService
final class MockImageApiService: ImageAPIServiceProtocol {
    // MARK: - Private properties

    private let imageData = UIImage(named: GlobalConstants.defaultImageName)?.pngData()

    // MARK: - Public methods

    func getImage(posterPath: String, size: Movie.SizeOfImages, completion: @escaping (Movie.GetImageResult) -> Void) {
        completion(GetImageResult.succes(cinema: imageData ?? Data()))
    }
}
