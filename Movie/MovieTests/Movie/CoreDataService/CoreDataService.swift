// CoreDataService.swift
// Copyright © Alexandr Grigorenko. All rights reserved.

import CoreData
import Foundation

/// Сервиc работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Private constants

    private enum Constants {
        static let containerName = "DataBaseCinema"
        static let emptyString = ""
    }

    // MARK: - Private properties

    private let context = AppDelegate.sharedAppDelegate.defaultPersistentContainer.viewContext

    // MARK: - Public methods

    func saveData(_ data: [Cinema]) {
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        saveCinemaLibrary(cinemaLibrary: data, context: context)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func loadData() -> [Cinema] {
        loadCinemaLibrary(context: context)
    }

    // MARK: - Private methods

    private func loadCinemaLibrary(context: NSManagedObjectContext) -> [Cinema] {
        var cinemaLibrary: [Cinema] = []
        let request: NSFetchRequest<DataBaseCinema> = DataBaseCinema.fetchRequest()
        do {
            try context.fetch(request).forEach {
                cinemaLibrary.append(Cinema(
                    title: $0.title ?? Constants.emptyString,
                    imagePath: $0.imagePath ?? Constants.emptyString,
                    modelOverview: $0.modelOverview ?? Constants.emptyString,
                    modelVoteAverage: $0.modelVoteAverage,
                    modelVoteCount: Int($0.modelVoteCount)
                ))
            }
            return cinemaLibrary
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func saveCinemaLibrary(cinemaLibrary: [Cinema], context: NSManagedObjectContext) {
        guard
            let entity = NSEntityDescription.entity(forEntityName: Constants.containerName, in: context)
        else { return }
        cinemaLibrary.forEach {
            let dataBaseCinema = DataBaseCinema(entity: entity, insertInto: context)
            dataBaseCinema.title = $0.title
            dataBaseCinema.modelOverview = $0.modelOverview
            dataBaseCinema.modelVoteAverage = $0.modelVoteAverage
            dataBaseCinema.modelVoteCount = Int64($0.modelVoteCount)
            dataBaseCinema.imagePath = $0.imagePath
        }
    }
}
