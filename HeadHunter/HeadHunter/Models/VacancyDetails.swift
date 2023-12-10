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
    let description: String
    let area: Area
}

// MARK: - Area

struct Area: Decodable {
    let name: String
}
