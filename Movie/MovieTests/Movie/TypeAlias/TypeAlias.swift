// TypeAlias.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import Foundation

typealias TapAction = (Cinema, Data) -> ()
typealias NewCinemaTapHandler = (ViewData) -> ()
typealias PopulareCinemaTapHandler = (ViewData) -> ()
typealias UpcomingCinemaHandler = (ViewData) -> ()
typealias FetchImageHandler = (String, Data) -> ()
typealias ShowErrorAlertHandler = (String) -> Void
