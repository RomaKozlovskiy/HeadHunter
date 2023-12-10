//
//  VacancyDetailsProvider.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacancyDetailsProvider

final class VacancyDetailsProvider: Provider {
    let vacancyDetailsRouter = VacancyDetailsRouter()
    var vacancyDetails: VacancyDetails?
    
    func fetchDetailedVacancy(by vacancyId: String) async throws -> VacancyDetails? {
        let route = vacancyDetailsRouter.vacancyDetailsRoute(by: vacancyId)
        let data = try await self.request(with: route)
        let vacancyDetails = try self.decode(vacancyDetails.self, data: data)
        return vacancyDetails
    }
}
