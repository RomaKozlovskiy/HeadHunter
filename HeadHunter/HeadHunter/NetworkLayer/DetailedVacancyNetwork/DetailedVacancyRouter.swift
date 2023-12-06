//
//  DetailedVacancyRouter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - DetailedVacancyRouter

class DetailedVacancyRouter: ApiRouterProtocol {
    func detailedVacancyRoute(by vacancyId: String) -> ApiRoute {
        var baseUrl = self.apiRoute()
        baseUrl.method = .get
        baseUrl.urlComponents.path = ApiPath.vacancies.rawValue + "/" + vacancyId
        return baseUrl
    }
}
