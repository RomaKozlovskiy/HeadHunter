//
//  CoreDataManager.swift
//  HeadHunter
//
//  Created by Роман Козловский on 13.12.2023.
//

// MARK: - Import

import UIKit
import CoreData

// MARK: - Protocol

protocol FavoriteVacanciesStoreProtocol {
    func createFavoriteVacancy(from vacancy: Item)
    func fetchFavoriteVacancies() -> [Item?]
    func fetchFavoriteVacancy(by id: String) -> FavoriteVacancy?
    func deleteAllFavoriteVacancies()
    func deleteFavoriteVacancy(by id: String)
}

// MARK: - CoreDataManager

final class FavoriteVacanciesStore: NSObject {
    
    // MARK: - Static Properties
    
    static var shared = FavoriteVacanciesStore()
    
    // MARK: - Init
    
    private override init() {}
    
    // MARK: - Private Properties
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
}

extension FavoriteVacanciesStore: FavoriteVacanciesStoreProtocol {
    
    // MARK: - Public Methods
    
    func createFavoriteVacancy(from vacancy: Item) {
        guard let favoriteVacancy = FavoriteVacancy.createFavoriteVacancy(context: context) else { return }
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
    
    func fetchFavoriteVacancies() -> [Item?] {
        let favoriteVacanciesEntity: [FavoriteVacancy] = FavoriteVacancy.fetchFavoriteVacanciesEntity(context: context)
        var favoriteVacancies: [Item?] = []
        
        favoriteVacanciesEntity.forEach { entity in
            let vacancy = Item(id: entity.id, name: entity.name, salary: Salary(from: Int(entity.salaryFrom), to: Int(entity.salaryTo), currency: entity.salaryCurrency), address: Address(city: entity.city, street: "", raw: ""), employer: Employer(id: "", name: entity.companyName, logoUrls: LogoUrls(the90: "", the240: "", original: entity.companyLogoUrl)), snippet: Snippet(requirement: "", responsibility: ""), experience: Employment(id: "", name: entity.experience), favoriteStatus: true)
            favoriteVacancies.append(vacancy)
        }
        return favoriteVacancies
    }
    
    func fetchFavoriteVacancy(by id: String) -> FavoriteVacancy? {
        let favoriteVacancy = FavoriteVacancy.fetchFavoriteVacancyEntity(by: id, context: context )
        return favoriteVacancy
    }
    
    func deleteAllFavoriteVacancies() {
        FavoriteVacancy.deleteAllFavoriteVacanciesEntity(context: context)
        appDelegate.saveContext()
    }
    
    func deleteFavoriteVacancy(by id: String) {
        FavoriteVacancy.deleteFavoriteVacancyEntity(by: id, context: context)
        appDelegate.saveContext()
    }
}
