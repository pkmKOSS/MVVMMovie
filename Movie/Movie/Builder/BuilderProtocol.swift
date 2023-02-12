// BuilderProtocol.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import UIKit

/// Протокол конструктора экранов
protocol BuilderProtocol {
    func buildCinemaListScreen() -> UIViewController
    func buildCinemaDescriptionScreen(cinema: Cinema, imageData: Data) -> UIViewController
}