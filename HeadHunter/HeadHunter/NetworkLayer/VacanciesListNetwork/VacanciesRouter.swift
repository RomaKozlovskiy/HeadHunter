//
//  VacanciesListRouter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 04.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacanciesRouter

class VacanciesRouter: ApiRouterProtocol {
    func vacanciesRoute() -> ApiRoute {
        var baseUrl = self.apiRoute()
        baseUrl.method = .get
        baseUrl.urlComponents.path = ApiPath.vacancyList.rawValue //TODO: - rename ApiPath.vacancyList
        return baseUrl
    }
}
