// CinemaListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран со списком кинофильмов.
final class CinemaListViewController: UIViewController {

    // MARK: - Public properties

    var viewModel: CinemaListScreenViewModel!
    var internalView: CinemaListInternalView!
    var toDescriptionScreen: ((Cinema) -> ())?

    // MARK: - Private properties

    private var actionHandler: TapAction?

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapAction()
        configureInternalView()
        configFetchImage()
        configGetPopular()
        getRequest()
    }

    // MARK: - Private methods

    private func configureInternalView() {
        view.addSubview(internalView)
        internalView.frame = view.frame
        guard let action = actionHandler else { return }
        internalView.configure(tapAction: action)
    }

    private func getRequest() {
        viewModel.fetchCinema()
    }

    private func configGetPopular() {
        viewModel.onPopulareCinemaTapHandler = { [weak self] viewData in
            guard let self = self else {
                return
            }
            self.internalView.viewData = viewData
        }
    }

    private func configureTapAction() {
        actionHandler = { [weak self] cinema in
            guard
                let self = self,
                let tapAction = self.toDescriptionScreen
            else { return }
            tapAction(cinema)
        }
    }

    private func configFetchImage() {
        viewModel.fetchImageHandler = { [weak self] (path, data) in
            guard let self = self else { return }
            self.internalView.cinemaImageMap[path] = data
        }
    }
}
