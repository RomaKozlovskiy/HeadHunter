//
//  VacanciesListProvider.swift
//  HeadHunter
//
//  Created by Роман Козловский on 04.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacanciesProvider

final class VacanciesProvider: Provider {
    
    // MARK: - Private Properties
    
    private let vacanciesRouter = VacanciesRouter()

    // MARK: - Public Methods
    
    func fetchVacancies(with searchText: String? = nil, currentPage: Int? = nil) async throws -> Vacancies? {
        var vacancies: Vacancies?
        do {
            let route = vacanciesRouter.vacanciesRoute(with: searchText, currentPage: currentPage)
            let data = try await self.request(with: route)
            vacancies = try self.decode(vacancies.self, data: data)
            return vacancies
        } catch let error {
            print(error)
        }
        return vacancies
    }
}
