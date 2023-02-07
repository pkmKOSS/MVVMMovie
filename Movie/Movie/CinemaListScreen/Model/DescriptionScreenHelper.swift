// DescriptionScreenHelper.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура для передачи данных на экран подробностей о фильме.
struct DescriptionScreenHelper {
    let title: String
    let imageData: Data
    let modelOverview: String
    let modelVoteAverage: Double
    let modelVoteCount: Int
}
