// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис получения фото
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Public methods

    func getImage(posterPath: String, size: SizeOfImages, completion: @escaping (GetImageResult) -> Void) {
        let urlString = "\(StringConstants.imageBaseUrl)\(size.rawValue)\(posterPath)"
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                let result = GetImageResult.succes(cinema: data)
                completion(result)
            } else if let error = error {
                let result = GetImageResult.failure(cinema: error)
                completion(result)
            }
        }.resume()
    }
}
