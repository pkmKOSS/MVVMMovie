// CinemaListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран со списком кинофильмов.
final class CinemaListViewController: UIViewController {
    // MARK: - Private types

    enum CellIdentifiers: String {
        case cinemaListIdentifier = "CinemaListCell"
    }

    // MARK: - Private properties

    private let condition = NSCondition()

    private var cinemaInfo: CinemaInfoProtocol? {
        willSet {
            DispatchQueue.main.async {
                self.descriptionScreenHelper = newValue?.results.map { result in
                    let imageData = self.getImage(posterPath: result.posterPath, size: .w500)

                    self.condition.wait()

                    return DescriptionScreenHelper(
                        title: result.title,
                        imageData: imageData,
                        modelOverview: result.overview,
                        modelVoteAverage: result.voteAverage,
                        modelVoteCount: result.voteCount
                    )
                }
            }
        }
    }

    private var descriptionScreenHelper: [DescriptionScreenHelper]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.cinemaListTableView.reloadData()
            }
        }
    }

    private var actionHandler: TapAction?

    // MARK: - Private visual components

    private var cinemaListTableView = UITableView()
    private var showUpcomingCinemaButton = UIButton()
    private var showPopularCinemaButton = UIButton()
    private var showNewCinemaButton = UIButton()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        getRequest()
    }

    // MARK: - private methods

    private func addSubviews() {
        view.addSubview(cinemaListTableView)
        view.addSubview(showUpcomingCinemaButton)
        view.addSubview(showPopularCinemaButton)
        view.addSubview(showNewCinemaButton)
        configureTapAction()
        configureViews()
    }

    private func configureViews() {
        view.backgroundColor = .white
        configureCinemaListTableView()
        configureShowUpcomingCinema()
        configureShowPopularCinemaButton()
        configureShowNewCinema()
        makeLayout()
    }

    private func makeLayout() {
        makeCinemaListTableViewLayout()
        makeShowUpcomingCinemaLayout()
        makeShowPopularCinemaButtonLayout()
        makeShowNewCinemaLayout()
    }

    private func configureCinemaListTableView() {
        cinemaListTableView.separatorColor = .white
        cinemaListTableView.dataSource = self
        cinemaListTableView.delegate = self
        cinemaListTableView.translatesAutoresizingMaskIntoConstraints = false

        cinemaListTableView.register(
            CinemaListTableViewCell.self,
            forCellReuseIdentifier: CellIdentifiers.cinemaListIdentifier.rawValue
        )
    }

    private func makeCinemaListTableViewLayout() {
        NSLayoutConstraint.activate([
            cinemaListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cinemaListTableView.topAnchor.constraint(equalTo: showUpcomingCinemaButton.bottomAnchor, constant: 10),
            cinemaListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cinemaListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureShowUpcomingCinema() {
        showUpcomingCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showUpcomingCinemaButton.setTitle(StringConstants.showUpcomingCinemaTitle, for: .normal)
        showUpcomingCinemaButton.backgroundColor = .systemYellow
        showUpcomingCinemaButton.layer.cornerRadius = 5
        showUpcomingCinemaButton.clipsToBounds = true
        showUpcomingCinemaButton.addTarget(self, action: #selector(getUpcomingCinemaAction), for: .touchUpInside)
    }

    private func makeShowUpcomingCinemaLayout() {
        NSLayoutConstraint.activate([
            showUpcomingCinemaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            showUpcomingCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            showUpcomingCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3)
        ])
    }

    private func configureShowPopularCinemaButton() {
        showPopularCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showPopularCinemaButton.setTitle(StringConstants.showPopularCinemaTitle, for: .normal)
        showPopularCinemaButton.backgroundColor = .systemYellow
        showPopularCinemaButton.layer.cornerRadius = 5
        showPopularCinemaButton.clipsToBounds = true
        showPopularCinemaButton.addTarget(self, action: #selector(getPopularCinemaAction), for: .touchUpInside)
    }

    private func makeShowPopularCinemaButtonLayout() {
        NSLayoutConstraint.activate([
            showPopularCinemaButton.leadingAnchor.constraint(
                equalTo: showUpcomingCinemaButton.trailingAnchor,
                constant: +5
            ),
            showPopularCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +5),
            showPopularCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3.1)
        ])
    }

    private func configureShowNewCinema() {
        NSLayoutConstraint.activate([
            showNewCinemaButton.leadingAnchor.constraint(equalTo: showPopularCinemaButton.trailingAnchor, constant: +5),
            showNewCinemaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +5),
            showNewCinemaButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3.1)
        ])
    }

    private func makeShowNewCinemaLayout() {
        showNewCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showNewCinemaButton.setTitle(StringConstants.showNewCinemaTitle, for: .normal)
        showNewCinemaButton.backgroundColor = .systemYellow
        showNewCinemaButton.layer.cornerRadius = 5
        showNewCinemaButton.clipsToBounds = true
    }

    private func getRequest() {
        NetworkManager.manager.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                self.cinemaInfo = cinema as? CinemaInfoProtocol
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.cinemaListTableView.reloadData()
            }
        }
    }

    private func configureTapAction() {
        actionHandler = { [weak self] helper in
            guard let self = self else { return }
            let viewController = CinemaDescriptionViewController(helper: helper)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    private func getImage(
        posterPath: String,
        size: SizeOfImages
    ) -> Data {
        var imageData = Data()
        NetworkManager.manager.getImage(
            posterPath: posterPath,
            size: size
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .succes(data):
                imageData = data
                self.condition.signal()
            case let .failure(cinema):
                print(cinema.localizedDescription)
            }
        }
        return imageData
    }

    // MARK: - @objc private methods

    @objc private func getUpcomingCinemaAction() {
        NetworkManager.manager.getCinema(typeOfRequest: .getUpcoming) { result in
            switch result {
            case let .succes(cinema):
                self.cinemaInfo = cinema as? InfoAboutCinema
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.cinemaListTableView.reloadData()
            }
        }
    }

    @objc private func getPopularCinemaAction() {
        NetworkManager.manager.getCinema(typeOfRequest: .getPopular) { result in
            switch result {
            case let .succes(cinema):
                self.cinemaInfo = cinema as? InfoAboutPopularCinema
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.cinemaListTableView.reloadData()
            }
        }
    }

    @objc private func getNewCinemaAction() {
        NetworkManager.manager.getCinema(typeOfRequest: .getNew) { result in
            switch result {
            case let .succes(cinema):
                self.cinemaInfo = cinema as? InfoAboutCinema
            case let .failure(cinema):
                print("error: - \(cinema.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.cinemaListTableView.reloadData()
            }
        }
    }
}

// Имплементация UITableViewDelegate, UITableViewDataSource
extension CinemaListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = cinemaInfo?.results.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(
                withIdentifier: CellIdentifiers.cinemaListIdentifier.rawValue,
                for: indexPath
            ) as? CinemaListTableViewCell
        else { return UITableViewCell() }
        guard let descriptionArray = descriptionScreenHelper else { return UITableViewCell() }
        guard let dataForDescriptionScreen = descriptionArray[safe: indexPath.row] else { return UITableViewCell() }
        cell.configureCell(
            description: dataForDescriptionScreen,
            handler: actionHandler
        )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
