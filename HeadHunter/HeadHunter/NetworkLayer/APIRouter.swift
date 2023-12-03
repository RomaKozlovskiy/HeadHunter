//
//  APIRouter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 03.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - ApiRouterProtocol

protocol ApiRouterProtocol {
    var config: Config { get }
    func apiRoute() -> ApiRoute
}

// MARK: - ApiRoute

struct ApiRoute {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    var urlComponents: URLComponents
    var method: Method
}

// MARK: - Extension ApiRouterProtocol Protocol

extension ApiRouterProtocol {
    var config: Config {
        return Config()
    }
    
    func apiRoute() -> ApiRoute {
        ApiRoute(urlComponents: config.getBaseUrl(), method: .get)
    }
}
