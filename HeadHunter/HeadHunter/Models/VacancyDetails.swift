//
//  DetailedVacancy.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - DetailedVacancy

struct VacancyDetails: Decodable {
    let id: String
    let name: String
    let salary: Salary?
    let address: Address?
    let experience: BillingType?
    let schedule: BillingType?
    let employment: BillingType?
    let professionalRole: [BillingType?]
    let employer: Employer?
    let description: String
    
    private enum CodingKeys: String, CodingKey {
       case id
       case name
       case salary
       case address
       case experience
       case schedule
       case employment
       case professionalRole = "professional_roles"
       case employer
       case description
    }
}

// MARK: - BillingType

struct BillingType: Decodable {
    let id: String?
    let name: String?
}

