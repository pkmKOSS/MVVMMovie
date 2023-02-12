// PosterTableViewCell.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Ячейка с паспортом.
final class PosterTableViewCell: UITableViewCell {
    // MARK: - Private visual components

    private var posterImageView = UIImageView()

    // MARK: - Public methods

    func configureCell(imageData: Data) {
        configurePosterImageView(imageData: imageData)
        makePosterImageViewLayout()
        configureContentView()
    }

    // MARK: - Private methods

    private func configurePosterImageView(imageData: Data) {
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.image = UIImage(data: imageData)
        posterImageView.contentMode = .scaleAspectFill
    }

    private func makePosterImageViewLayout() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureContentView() {
        selectionStyle = .none
    }
}
