// CinemaListCell.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Ячейка с описанием фильма.
final class CinemaListTableViewCell: UITableViewCell {
    // MARK: - Private visual components

    private var cinemaAvatarImageView = UIImageView()
    private var cinemaDescriptionLabel = UILabel()
    private var cinemaNameLabel = UILabel()
    private var ratingLabel = UILabel()
    private var countOfVoteLabel = UILabel()
    private var actionHandler: TapAction?
    private var cinemaDescription: Cinema?
    private var imageData: Data?

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func configureCell(
        cinema: Cinema?,
        handler: TapAction? = nil,
        imageData: Data? = nil
    ) {
        actionHandler = handler
        cinemaDescription = cinema
        guard
            let cinema = cinema
        else { return }
        self.imageData = imageData
        configureCinemaAvatarImageView(imageData: imageData ?? Data())
        configureCinemaNameLabel(title: cinema.title)
        configureCinemaDescriptionLabel(modelOverview: cinema.modelOverview)
        configureRatingLabel(modelVoteAverage: cinema.modelVoteAverage)
        configureVoteLabel(modelVoteCount: cinema.modelVoteCount)
        addTapGestoreRecognizer()
        selectionStyle = .none
    }

    // MARK: - Private methods

    private func configureCinemaAvatarImageView(imageData: Data) {
        addSubview(cinemaAvatarImageView)
        cinemaAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        cinemaAvatarImageView.contentMode = .scaleAspectFill
        cinemaAvatarImageView.clipsToBounds = true
        cinemaAvatarImageView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            cinemaAvatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: +10),
            cinemaAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: +10),
            cinemaAvatarImageView.heightAnchor.constraint(equalToConstant: 200),
            cinemaAvatarImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        guard let image = UIImage(data: imageData) else { return }
        cinemaAvatarImageView.image = image
    }

    private func configureCinemaNameLabel(title: String) {
        addSubview(cinemaNameLabel)
        cinemaNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cinemaNameLabel.text = title
        cinemaNameLabel.textAlignment = .center
        cinemaNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cinemaNameLabel.textColor = .systemYellow
        cinemaNameLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            cinemaNameLabel.leadingAnchor.constraint(
                equalTo: cinemaAvatarImageView.leadingAnchor
            ),
            cinemaNameLabel.topAnchor.constraint(equalTo: cinemaAvatarImageView.bottomAnchor, constant: +10),
            cinemaNameLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            )
        ])
    }

    private func configureCinemaDescriptionLabel(modelOverview: String) {
        addSubview(cinemaDescriptionLabel)
        cinemaDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cinemaDescriptionLabel.text = "\(modelOverview)"
        cinemaDescriptionLabel.textAlignment = .justified
        cinemaDescriptionLabel.lineBreakMode = .byClipping
        cinemaDescriptionLabel.numberOfLines = 0
        cinemaDescriptionLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            cinemaDescriptionLabel.leadingAnchor.constraint(
                equalTo: cinemaAvatarImageView.leadingAnchor
            ),
            cinemaDescriptionLabel.topAnchor.constraint(equalTo: cinemaNameLabel.bottomAnchor, constant: +10),
            // cinemaDescriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            cinemaDescriptionLabel.trailingAnchor.constraint(
                equalTo: cinemaAvatarImageView.trailingAnchor
            ),
        ])
    }

    private func configureRatingLabel(modelVoteAverage: Double) {
        addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "Оценка: \(modelVoteAverage)"
        ratingLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(
                equalTo: cinemaAvatarImageView.leadingAnchor
            ),
            ratingLabel.topAnchor.constraint(equalTo: cinemaDescriptionLabel.bottomAnchor, constant: +10),
            ratingLabel.trailingAnchor.constraint(
                equalTo: cinemaAvatarImageView.trailingAnchor
            )
        ])
    }

    private func configureVoteLabel(modelVoteCount: Int) {
        addSubview(countOfVoteLabel)
        countOfVoteLabel.translatesAutoresizingMaskIntoConstraints = false
        countOfVoteLabel.text = "Оценили: \(modelVoteCount) пользователей"
        countOfVoteLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            countOfVoteLabel.leadingAnchor.constraint(
                equalTo: cinemaAvatarImageView.leadingAnchor
            ),
            countOfVoteLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: +10),
            countOfVoteLabel.trailingAnchor.constraint(
                equalTo: cinemaAvatarImageView.trailingAnchor
            ),
            countOfVoteLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func addTapGestoreRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(gestoreAction))
        cinemaAvatarImageView.isUserInteractionEnabled = true
        cinemaAvatarImageView.addGestureRecognizer(recognizer)
    }

    @objc private func gestoreAction() {
        guard
            let tapAction = actionHandler,
            let cinemaDescription = cinemaDescription,
            let imageData = imageData
        else {
            return
        }
        tapAction(cinemaDescription, imageData)
    }
}
