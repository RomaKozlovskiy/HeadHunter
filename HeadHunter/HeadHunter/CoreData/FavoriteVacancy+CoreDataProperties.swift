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
