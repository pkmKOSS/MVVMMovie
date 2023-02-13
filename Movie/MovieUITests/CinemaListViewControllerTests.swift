// CinemaListViewControllerTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import XCTest

/// Тесты пользовательского интерфейса
final class CinemaListViewControllerTests: XCTestCase {
    // MARK: - Public methods

    func testCinemaListViewController() throws {
        let app = XCUIApplication()
        app.launch()

        let alertsElements = app.alerts.scrollViews.otherElements
        let alertsTextField = alertsElements.collectionViews.cells.children(
            matching:
            .other
        ).element.children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        let alertsOkButton = alertsElements.buttons[GlobalConstants.okButtonName]

        let tablesQuery = app.tables.cells
        let blackPantherCell = tablesQuery.cells.element(boundBy: 0)

        alertsTextField.tap()
        alertsTextField.typeText(GlobalConstants.apiKeyForTest)
        alertsOkButton.tap()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(blackPantherCell.exists)
        }
    }

    func testCinemaDescriptionViewController() throws {
        let app = XCUIApplication()
        app.launch()

        let elementsQuery = app.alerts.scrollViews.otherElements
        elementsQuery.collectionViews.cells.children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element(boundBy: 1)
            .children(matching: .textField).element.tap()
        elementsQuery.collectionViews.cells.children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element(boundBy: 1)
            .children(matching: .textField).element.typeText(GlobalConstants.apiKeyForTest)
        elementsQuery.buttons[GlobalConstants.okButtonName].tap()
        app.tables.cells
            .containing(
                .staticText,
                identifier: GlobalConstants.cellIDName
            ).children(matching: .image).element.tap()
        let tappedCell = app.tables.cells
            .containing(
                .button,
                identifier: GlobalConstants.cellButtonName
            ).element
        XCTAssertTrue(tappedCell.exists)
    }
}
