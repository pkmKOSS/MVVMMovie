// CinemaListInternalView.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Внутреннее представление экрана со списком фильмов
final class CinemaListInternalView: UIView {
    // MARK: - Private types

    enum CellIdentifiers: String {
        case cinemaListIdentifier = "CinemaListCell"
    }

    // MARK: - Private visual components

    private var cinemaListTableView = UITableView()
    private var buttonsStackView = UIStackView()
    private var showUpcomingCinemaButton = UIButton()
    private var showPopularCinemaButton = UIButton()
    private var showNewCinemaButton = UIButton()

    // MARK: - Public properties

    var viewData: ViewData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.layoutIfNeeded()
            }
        }
    }

    var cinemaImageMap: [String: Data] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.layoutIfNeeded()
            }
        }
    }

    // MARK: - Private properties

    private var tapActionHandler: ((Cinema, Data) -> ())?
    private var tapOnButtonHandler: ((TypeOfCinemaRequset) -> ())?
    private var descriptionScreenHelper: [Cinema] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func configure(
        tapAction: @escaping (Cinema, Data) -> (),
        tapOnButtonAction: @escaping ((TypeOfCinemaRequset) -> ())
    ) {
        tapActionHandler = tapAction
        tapOnButtonHandler = tapOnButtonAction
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        switch viewData {
        case .initial:
            break
        case .loading:
            break
        case let .success(cinema):
            descriptionScreenHelper = cinema
            cinemaListTableView.reloadData()
        }
    }

    // MARK: - private methods

    private func addSubviews() {
        addSubview(cinemaListTableView)
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(showUpcomingCinemaButton)
        buttonsStackView.addArrangedSubview(showPopularCinemaButton)
        buttonsStackView.addArrangedSubview(showNewCinemaButton)
        configureViews()
    }

    private func configureViews() {
        backgroundColor = .white
        configureCinemaListTableView()
        configureButtonsStackView()
        makeLayout()
    }

    private func makeLayout() {
        makeCinemaListTableViewLayout()
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
            cinemaListTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            cinemaListTableView.topAnchor.constraint(equalTo: showUpcomingCinemaButton.bottomAnchor, constant: 10),
            cinemaListTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cinemaListTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 5
        configureShowUpcomingCinema()
        configureShowPopularCinemaButton()
        configureShowNewCinema()
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            buttonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 30)
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

    private func configureShowPopularCinemaButton() {
        showPopularCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showPopularCinemaButton.setTitle(StringConstants.showPopularCinemaTitle, for: .normal)
        showPopularCinemaButton.backgroundColor = .systemYellow
        showPopularCinemaButton.layer.cornerRadius = 5
        showPopularCinemaButton.clipsToBounds = true
        showPopularCinemaButton.addTarget(self, action: #selector(getPopularCinemaAction), for: .touchUpInside)
    }

    private func configureShowNewCinema() {
        showNewCinemaButton.translatesAutoresizingMaskIntoConstraints = false
        showNewCinemaButton.setTitle(StringConstants.showNewCinemaTitle, for: .normal)
        showNewCinemaButton.backgroundColor = .systemYellow
        showNewCinemaButton.layer.cornerRadius = 5
        showNewCinemaButton.clipsToBounds = true
        showNewCinemaButton.addTarget(self, action: #selector(getNewCinemaAction), for: .touchUpInside)
    }

    // MARK: - @objc private methods

    @objc private func getUpcomingCinemaAction() {
        guard let action = tapOnButtonHandler else { return }
        action(.getUpcoming)
    }

    @objc private func getPopularCinemaAction() {
        guard let action = tapOnButtonHandler else { return }
        action(.getPopular)
    }

    @objc private func getNewCinemaAction() {
        guard let action = tapOnButtonHandler else { return }
        action(.getNew)
    }
}

// Имплементация UITableViewDelegate, UITableViewDataSource
extension CinemaListInternalView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let .success(cinema) = viewData else { return 0 }
        return cinema.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            case let .success(cinema) = viewData,
            let cell = tableView
            .dequeueReusableCell(
                withIdentifier: CellIdentifiers.cinemaListIdentifier.rawValue,
                for: indexPath
            ) as? CinemaListTableViewCell,
            let dataForDescriptionScreen = cinema[safe: indexPath.row]
        else {
            return UITableViewCell()
        }

        cell.configureCell(
            cinema: dataForDescriptionScreen,
            handler: tapActionHandler,
            imageData: cinemaImageMap[dataForDescriptionScreen.imagePath]
        )
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
