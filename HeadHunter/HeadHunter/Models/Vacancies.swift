//
//  VacanciesList.swift
//  HeadHunter
//
//  Created by Роман Козловский on 04.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - Vacancies

struct Vacancies: Decodable {
    var items: [Item]
    let found: Int
    let pages: Int
    let perPage: Int
    var page: Int
    let alternateUrl: String
    
   private enum CodingKeys: String, CodingKey {
        case items
        case found
        case pages
        case perPage = "per_page"
        case page
        case alternateUrl = "alternate_url"
    }
}

// MARK: - Item

struct Item: Decodable {
    let id: String?
    let name: String?
    let salary: Salary?
    let address: Address?
    let employer: Employer?
    let snippet: Snippet?
    let experience: Employment?
    var favoriteStatus: Bool?
}

// MARK: - Salary

struct Salary: Decodable {
    let from: Int?
    let to: Int?
    let currency: String?
}

// MARK: - Address

struct Address: Decodable {
    let city: String?
    let street: String?
    let raw: String?
}

// MARK: - Employer

struct Employer: Decodable {
    let id: String?
    let name: String?
    let logoUrls: LogoUrls?
    
    private enum CodingKeys: String, CodingKey {
       case id
       case name
       case logoUrls = "logo_urls"
    }
}

// MARK: - LogoUrls

struct LogoUrls: Decodable {
    let the90: String?
    let the240: String?
    let original: String?
    
    private enum CodingKeys: String, CodingKey {
            case the90 = "90"
            case the240 = "240"
            case original
        }
}

// MARK: - Snippet

struct Snippet: Decodable {
    let requirement: String?
    let responsibility: String?
}

// MARK: - Employment

struct Employment: Decodable {
    let id: String?
    let name: String?
}
