//
//  VacanciesListRouter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 04.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacanciesRouter

final class VacanciesRouter: ApiRouterProtocol {
    func vacanciesRoute(searchText: String?, currentPage: Int?) -> ApiRoute {
        var baseUrl = self.apiRoute()
        baseUrl.method = .get
        baseUrl.urlComponents.path = ApiPath.vacancies.rawValue
        
        if searchText != nil {
            var queryItems: [URLQueryItem] = baseUrl.urlComponents.queryItems ?? []
            let vacanciesQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "text", value: searchText)
            ]
            vacanciesQueryItems.forEach { queryItem in
                queryItems.append(queryItem)
            }
            baseUrl.urlComponents.queryItems = queryItems
        }
        
        if currentPage != nil {
            var queryItems: [URLQueryItem] = baseUrl.urlComponents.queryItems ?? []
            let vacanciesQueryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: String(currentPage ?? 0)),
                URLQueryItem(name: "per_page", value: "20")
            ]
            vacanciesQueryItems.forEach { queryItem in
                queryItems.append(queryItem)
            }
            baseUrl.urlComponents.queryItems = queryItems
        }
        return baseUrl
    }
}
