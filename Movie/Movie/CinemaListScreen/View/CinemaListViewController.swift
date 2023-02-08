// CinemaListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран со списком кинофильмов.
final class CinemaListViewController: UIViewController {
    // MARK: - Public properties

    var viewModel: CinemaListScreenViewModel!
    var internalView: CinemaListInternalView!
    var toDescriptionScreen: ((Cinema, Data) -> ())?

    // MARK: - Private properties

    private var actionHandler: TapAction?
    private var tapOnButtonHandler: ((TypeOfCinemaRequset) -> ())?

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }

    // MARK: - Private methods

    private func configureScreen() {
        configureTapAction()
        configFetchImage()
        configureFetchPopularCinemaHandler()
        configureFetchUpcomingCinemaHandler()
        configureFetchNewCinemaHandler()
        configureInternalView()
        configureShowAlertHandle()
        fetchCinema(typeOfCinema: .getPopular)
    }

    private func configureInternalView() {
        view.addSubview(internalView)
        internalView.frame = view.frame
        guard
            let tapOnCellAction = actionHandler,
            let tapOnButtonAction = tapOnButtonHandler
        else { return }
        internalView.configure(tapAction: tapOnCellAction, tapOnButtonAction: tapOnButtonAction)
    }

    private func fetchCinema(typeOfCinema: TypeOfCinemaRequset) {
        viewModel.fetchCinema(typeOfCinema: typeOfCinema)
    }

    private func configureFetchPopularCinemaHandler() {
        viewModel.onPopulareCinemaTapHandler = { [weak self] viewData in
            guard let self = self else {
                return
            }
            self.internalView.viewData = viewData
        }
    }

    private func configureFetchNewCinemaHandler() {
        viewModel.onNewCinemaTapHandler = { [weak self] viewData in
            guard let self = self else {
                return
            }
            self.internalView.viewData = viewData
        }
    }

    private func configureFetchUpcomingCinemaHandler() {
        viewModel.onUpcomingCinemaTapHandler = { [weak self] viewData in
            guard let self = self else {
                return
            }
            self.internalView.viewData = viewData
        }
    }

    private func configureShowAlertHandle() {
        viewModel.showErrorAlertHandler = { [weak self] localizedError in
            let alert = UIAlertController(title: nil, message: "\(localizedError)", preferredStyle: .alert)
            self?.navigationController?.present(alert, animated: true)
        }
    }

    private func configureTapAction() {
        actionHandler = { [weak self] cinema, data in
            guard
                let self = self,
                let tapAction = self.toDescriptionScreen
            else { return }
            tapAction(cinema, data)
        }

        tapOnButtonHandler = { [weak self] typeOfCinema in
            guard
                let self = self
            else { return }
            self.fetchCinema(typeOfCinema: typeOfCinema)
        }
    }

    private func configFetchImage() {
        viewModel.fetchImageHandler = { [weak self] path, data in
            guard let self = self else { return }
            self.internalView.cinemaImageMap[path] = data
        }
    }
}
