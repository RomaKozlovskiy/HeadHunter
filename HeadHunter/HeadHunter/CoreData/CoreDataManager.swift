//
//  CoreDataManager.swift
//  HeadHunter
//
//  Created by Роман Козловский on 13.12.2023.
//

// MARK: - Import

import UIKit
import CoreData

// MARK: - CoreDataManager

final class CoreDataManager: NSObject {
    
    // MARK: - Static Properties
    
    static var shared = CoreDataManager()
    
    // MARK: - Init
    
    private override init() {}
    
    // MARK: - Private Properties
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    
    func createFavoriteVacancy(from vacancy: Item) {
        guard let favoriteVacancyEntityDescription = NSEntityDescription.entity(forEntityName: "FavoriteVacancy", in: context) else { return } //TODO: - make throws func
        let favoriteVacancy = FavoriteVacancy(entity: favoriteVacancyEntityDescription, insertInto: context)
        favoriteVacancy.id = vacancy.id
        favoriteVacancy.name = vacancy.name
        favoriteVacancy.salaryFrom = Int32(vacancy.salary?.from ?? 0)
        favoriteVacancy.salaryTo = Int32(vacancy.salary?.to ?? 0)
        favoriteVacancy.salaryCurrency = vacancy.salary?.currency
        favoriteVacancy.city = vacancy.address?.city
        favoriteVacancy.companyName = vacancy.employer?.name
        favoriteVacancy.experience = vacancy.experience?.name
        favoriteVacancy.companyLogoUrl = vacancy.employer?.logoUrls?.original
        appDelegate.saveContext()
    }
    
    func fetchFavoriteVacancies() -> [FavoriteVacancy] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            return try context.fetch(request) as! [FavoriteVacancy]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func fetchFavoriteVacancy(by id: String) -> FavoriteVacancy? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let favoriteVacancies = try context.fetch(request) as? [FavoriteVacancy]
            return favoriteVacancies?.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func deleteAllFavoriteVacancies() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            let favoriteVacancies = try context.fetch(request) as? [FavoriteVacancy]
            favoriteVacancies?.forEach( { context.delete($0) })
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteFavoriteVacancy(by id: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            guard let favoriteVacancies = try context.fetch(request) as? [FavoriteVacancy],
                  let favoriteVacancy = favoriteVacancies.first(where: { $0.id == id }) else { return }
            context.delete(favoriteVacancy)
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
}
