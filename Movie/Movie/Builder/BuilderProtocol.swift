// BuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол конструктора экранов
protocol BuilderProtocol {
    func buildCinemaListScreen() -> UIViewController
    func buildCinemaDescriptionScreen(cinema: Cinema) -> UIViewController
}
