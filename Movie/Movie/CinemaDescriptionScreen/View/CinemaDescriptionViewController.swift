// CinemaDescriptionViewController.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Экран с подробным описанием фильма.
final class CinemaDescriptionViewController: UIViewController {
    // MARK: - Private enums

    enum CellTypes {
        case posterCell
        case buttonsCell
        case overviewCell
        case ratingCell
    }

    enum CellIdentifier: String {
        case posterCellIdentifier = "PosterTableViewCell"
        case buttonsCellIdentifier = "ButtonsTableViewCell"
        case overviewCellIdentifier = "OverviewTableViewCell"
        case ratingCellIdentifier = "RatingTableViewCell"
    }

    // MARK: - Public properties

    var viewModel: CinemaDescriptionViewModelProtocol!

    // MARK: - Private properties

    private let cinema: Cinema
    private let imageData: Data
    private let cellTypes: [CellTypes] = [.posterCell, .buttonsCell, .overviewCell, .ratingCell]

    // MARK: - Private visual components

    private var tableView = UITableView()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureScene()
    }

    // MARK: Init

    init(
        cinema: Cinema,
        imageData: Data
    ) {
        self.cinema = cinema
        self.imageData = imageData
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func configureScene() {
        tableView.separatorColor = .clear
        addSubview()
        makeTableViewLayout()
        configureTableViewDelegates()
    }

    private func addSubview() {
        view.addSubview(tableView)
    }

    private func configureTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func makeTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            PosterTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.posterCellIdentifier.rawValue
        )
        tableView.register(
            ButtonsTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.buttonsCellIdentifier.rawValue
        )
        tableView.register(
            OverviewTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.overviewCellIdentifier.rawValue
        )
        tableView.register(
            RatingTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.ratingCellIdentifier.rawValue
        )

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

/// Методы UITableViewDataSource, UITableViewDelegate
extension CinemaDescriptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[safe: indexPath.row]
        switch type {
        case .posterCell:
            guard let
                cell = tableView.dequeueReusableCell(
                    withIdentifier: CellIdentifier.posterCellIdentifier.rawValue,
                    for: indexPath
                ) as? PosterTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(imageData: imageData)
            return cell
        case .buttonsCell:
            guard let
                cell = tableView.dequeueReusableCell(
                    withIdentifier: CellIdentifier.buttonsCellIdentifier.rawValue,
                    for: indexPath
                ) as? ButtonsTableViewCell
            else { return UITableViewCell() }
            cell.configureCell()
            return cell
        case .overviewCell:
            guard let
                cell = tableView.dequeueReusableCell(
                    withIdentifier: CellIdentifier.overviewCellIdentifier.rawValue,
                    for: indexPath
                ) as? OverviewTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(overViewText: cinema.modelOverview)
            return cell
        case .ratingCell:
            guard let
                cell = tableView.dequeueReusableCell(
                    withIdentifier: CellIdentifier.ratingCellIdentifier.rawValue,
                    for: indexPath
                ) as? RatingTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                countOfVote: cinema.modelVoteCount,
                avarageVote: cinema.modelVoteAverage
            )
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
