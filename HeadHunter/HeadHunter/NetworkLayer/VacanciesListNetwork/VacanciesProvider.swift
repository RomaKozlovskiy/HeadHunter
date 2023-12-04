//
//  VacanciesListProvider.swift
//  HeadHunter
//
//  Created by Роман Козловский on 04.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacanciesProvider

class VacanciesProvider: Provider {
    let vacanciesRouter = VacanciesRouter()
    var vacancies: Vacancies?
    
    func fetchVacancies() async throws -> Vacancies? {
        let route = vacanciesRouter.vacanciesRoute()
        let data = try await self.request(with: route)
        let vacancies = try self.decode(vacancies.self, data: data)
        return vacancies
    }
}
