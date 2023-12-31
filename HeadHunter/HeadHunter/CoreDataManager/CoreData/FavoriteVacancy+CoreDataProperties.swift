//
//  FavoriteVacancy+CoreDataProperties.swift
//  HeadHunter
//
//  Created by Роман Козловский on 13.12.2023.
//
//

// MARK: - Import

import Foundation
import CoreData

// MARK: - FavoriteVacancy

@objc(FavoriteVacancy)
public class FavoriteVacancy: NSManagedObject {
    
}

// MARK: - Extension FavoriteVacancy

extension FavoriteVacancy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteVacancy> {
        return NSFetchRequest<FavoriteVacancy>(entityName: "FavoriteVacancy")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var salaryFrom: Int32
    @NSManaged public var salaryTo: Int32
    @NSManaged public var salaryCurrency: String?
    @NSManaged public var city: String?
    @NSManaged public var companyName: String?
    @NSManaged public var experience: String?
    @NSManaged public var companyLogoUrl: String?
    
}

extension FavoriteVacancy : Identifiable {

}

extension FavoriteVacancy {
    class func createFavoriteVacancy(context: NSManagedObjectContext) -> FavoriteVacancy? {
        guard let favoriteVacancyEntityDescription = NSEntityDescription.entity(forEntityName: "FavoriteVacancy", in: context) else { return nil }
        return FavoriteVacancy(entity: favoriteVacancyEntityDescription, insertInto: context)
    }
    
    class func fetchFavoriteVacanciesEntity(context: NSManagedObjectContext) -> [FavoriteVacancy] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            return try context.fetch(request) as! [FavoriteVacancy]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    class func fetchFavoriteVacancyEntity(by id: String, context: NSManagedObjectContext) -> FavoriteVacancy? {
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
    
    class func deleteAllFavoriteVacanciesEntity(context: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            let favoriteVacancies = try context.fetch(request) as? [FavoriteVacancy]
            favoriteVacancies?.forEach( { context.delete($0) })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    class func deleteFavoriteVacancyEntity(by id: String, context: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteVacancy")
        do {
            guard let favoriteVacancies = try context.fetch(request) as? [FavoriteVacancy],
                  let favoriteVacancy = favoriteVacancies.first(where: { $0.id == id }) else { return }
            context.delete(favoriteVacancy)
        } catch {
            print(error.localizedDescription)
        }
    }
}
