//
//  DetailedVacancyProvider.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - DetailedVacancyProvider

class DetailedVacancyProvider: Provider {
    let detailedVacancyRouter = DetailedVacancyRouter()
    var detailedVacancy: DetailedVacancy?
    
    func fetchDetailedVacancy(by vacancyId: String) async throws -> DetailedVacancy? {
        let route = detailedVacancyRouter.detailedVacancyRoute(by: vacancyId)
        let data = try await self.request(with: route)
        let detailedVacancy = try self.decode(detailedVacancy.self, data: data)
        return detailedVacancy
    }
}
