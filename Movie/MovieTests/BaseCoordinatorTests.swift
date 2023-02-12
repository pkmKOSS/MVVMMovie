// BaseCoordinatorTests.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

@testable import Movie
import XCTest

/// Тесты BaseCoordinator
final class BaseCoordinatorTests: XCTestCase {
    // MARK: - Private properties

    private var baseCoordinator: BaseCoordinatorProtocol!
    private var fakeCoordinator: BaseCoordinatorProtocol!

    // MARK: - Public methods

    override func setUpWithError() throws {
        baseCoordinator = BaseCoordinator()
        fakeCoordinator = MockCoordinator()
    }

    func testAddDependency() throws {
        baseCoordinator.addDependency(fakeCoordinator)
        baseCoordinator.addDependency(fakeCoordinator)
        let isCoordinatorAppend = baseCoordinator.childCoordinators.isEmpty
        let countOfChildCoordinators = baseCoordinator.childCoordinators.count
        XCTAssertEqual(countOfChildCoordinators, 1)
        XCTAssertFalse(isCoordinatorAppend)
    }

    func testRemoveDependency() throws {
        baseCoordinator.addDependency(fakeCoordinator)
        baseCoordinator.removeDependency(fakeCoordinator)
        let isCoordinatorRemoved = baseCoordinator.childCoordinators.isEmpty
        XCTAssertTrue(isCoordinatorRemoved)
    }

    func testBaseCoordinator() throws {
        baseCoordinator.start()
        let isCoordinatorStarted = baseCoordinator.isStarted
        XCTAssertTrue(isCoordinatorStarted)
    }
}
