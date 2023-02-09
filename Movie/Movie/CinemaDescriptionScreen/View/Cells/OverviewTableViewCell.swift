// OverviewTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с текстовым описанием фильма.
final class OverviewTableViewCell: UITableViewCell {
    // MARK: - Private visual component

    private var overviewLabel = UILabel()

    // MARK: - Public methods

    func configureCell(overViewText: String) {
        configureContentView()
        configureOverViewLabel(overViewText: overViewText)
        makeOverviewLabelLayout()
    }

    // MARK: - Private methods

    private func configureContentView() {
        contentView.layer.shadowColor = UIColor.systemYellow.cgColor
        contentView.layer.shadowRadius = 3.0
        contentView.layer.shadowOpacity = 3.0
        contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        contentView.layer.masksToBounds = false
        backgroundColor = .systemYellow
        selectionStyle = .none
    }

    private func configureOverViewLabel(overViewText: String) {
        addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 0
        overviewLabel.lineBreakMode = .byWordWrapping
        overviewLabel.text = overViewText
        overviewLabel.textAlignment = .center
        overviewLabel.backgroundColor = #colorLiteral(red: 1, green: 0.6496947554, blue: 0.5652575739, alpha: 1)
        overviewLabel.layer.shadowColor = #colorLiteral(red: 1, green: 0.6496947554, blue: 0.5652575739, alpha: 1).cgColor
        overviewLabel.layer.shadowOpacity = 100
        overviewLabel.layer.shadowOffset = .zero
        overviewLabel.layer.shadowRadius = 15
        overviewLabel.layer.cornerRadius = 5
    }

    private func makeOverviewLabelLayout() {
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: topAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: +15),
        ])
    }
}
