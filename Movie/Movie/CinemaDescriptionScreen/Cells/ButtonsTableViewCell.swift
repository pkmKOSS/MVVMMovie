// ButtonsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с кнопками показа трейлера и избранным.
final class ButtonsTableViewCell: UITableViewCell {
    // MARK: - Private visual components

    private var showTrailerButton = UIButton()
    private var favoriteFlagImageView = UIImageView()
    private var showLaterLabel = UILabel()
    private var downloadImageView = UIImageView()
    private var downloadLabel = UILabel()

    // MARK: - Public methods

    func configureCell() {
        addSubviews()
        configureCellContentView()
        configureViews()
        makeLayout()
        configureCellContentView()
    }

    // MARK: - Private methods

    private func addSubviews() {
        addSubview(showTrailerButton)
        addSubview(favoriteFlagImageView)
        addSubview(showLaterLabel)
        addSubview(downloadImageView)
        addSubview(downloadLabel)
    }

    private func configureCellContentView() {
        backgroundColor = #colorLiteral(red: 1, green: 0.6496947554, blue: 0.5652575739, alpha: 1)
        selectionStyle = .none
    }

    private func makeLayout() {
        makeShowTrailerButtonLayout()
        makeLayoutFavoriteFlagImageView()
        makeShowLaterLabelLayout()
        makeDownloadImageViewLayout()
        makeDownloadLabelLayout()
    }

    private func configureViews() {
        configureShowTrailerButton()
        configureFavoriteFlagImageView()
        configureShowLaterLabel()
        configureDownloadImageView()
        configureDownloadLabel()
    }

    private func configureShowTrailerButton() {
        showTrailerButton.translatesAutoresizingMaskIntoConstraints = false
        showTrailerButton.setTitle(StringConstants.showTrailerButtonSetTitle, for: .normal)
        showTrailerButton.setTitleColor(.systemRed, for: .normal)
        showTrailerButton.backgroundColor = .systemYellow
        showTrailerButton.layer.cornerRadius = 5
        showTrailerButton.clipsToBounds = true
    }

    private func makeShowTrailerButtonLayout() {
        NSLayoutConstraint.activate([
            showTrailerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            showTrailerButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            showTrailerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }

    private func configureFavoriteFlagImageView() {
        favoriteFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteFlagImageView.image = UIImage(systemName: StringConstants.favoriteFlagImageViewImageName)
        favoriteFlagImageView.tintColor = .systemRed
        favoriteFlagImageView.contentMode = .scaleAspectFill
    }

    private func makeLayoutFavoriteFlagImageView() {
        NSLayoutConstraint.activate([
            favoriteFlagImageView.topAnchor.constraint(equalTo: showTrailerButton.bottomAnchor, constant: 10),
            favoriteFlagImageView.leadingAnchor.constraint(equalTo: showTrailerButton.leadingAnchor, constant: 32),
            favoriteFlagImageView.heightAnchor.constraint(equalTo: showTrailerButton.heightAnchor),
            favoriteFlagImageView.widthAnchor.constraint(equalTo: favoriteFlagImageView.widthAnchor)
        ])
    }

    private func configureShowLaterLabel() {
        showLaterLabel.translatesAutoresizingMaskIntoConstraints = false
        showLaterLabel.font = UIFont.systemFont(ofSize: 10)
        showLaterLabel.text = StringConstants.showLaterLabelText
    }

    private func makeShowLaterLabelLayout() {
        NSLayoutConstraint.activate([
            showLaterLabel.topAnchor.constraint(equalTo: favoriteFlagImageView.bottomAnchor, constant: 5),
            showLaterLabel.heightAnchor.constraint(equalToConstant: 30),
            showLaterLabel.centerXAnchor.constraint(equalTo: favoriteFlagImageView.centerXAnchor),
            showLaterLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureDownloadImageView() {
        downloadImageView.translatesAutoresizingMaskIntoConstraints = false
        downloadImageView.image = UIImage(systemName: StringConstants.downloadImageViewImageName)
        downloadImageView.tintColor = .systemRed
        downloadImageView.contentMode = .scaleAspectFill
    }

    private func makeDownloadImageViewLayout() {
        NSLayoutConstraint.activate([
            downloadImageView.topAnchor.constraint(equalTo: showTrailerButton.bottomAnchor, constant: 10),
            downloadImageView.trailingAnchor.constraint(equalTo: showTrailerButton.trailingAnchor, constant: -32),
            downloadImageView.heightAnchor.constraint(equalTo: showTrailerButton.heightAnchor),
            downloadImageView.widthAnchor.constraint(equalTo: favoriteFlagImageView.widthAnchor)
        ])
    }

    private func configureDownloadLabel() {
        downloadLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadLabel.font = UIFont.systemFont(ofSize: 10)
        downloadLabel.text = StringConstants.downloadLabelText
    }

    private func makeDownloadLabelLayout() {
        NSLayoutConstraint.activate([
            downloadLabel.topAnchor.constraint(equalTo: downloadImageView.bottomAnchor, constant: 5),
            downloadLabel.heightAnchor.constraint(equalToConstant: 30),
            downloadLabel.centerXAnchor.constraint(equalTo: downloadImageView.centerXAnchor),
            downloadLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
