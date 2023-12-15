//
//  VacancyDetailsRouter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacancyDetailsRouter

final class VacancyDetailsRouter: ApiRouterProtocol {
    func vacancyDetailsRoute(by vacancyId: String) -> ApiRoute {
        var baseUrl = self.apiRoute()
        baseUrl.method = .get
        baseUrl.urlComponents.path = ApiPath.vacancies.rawValue + "/" + vacancyId
        return baseUrl
    }
}
