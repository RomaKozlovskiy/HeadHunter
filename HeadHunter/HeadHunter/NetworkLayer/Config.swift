//
//  Config.swift
//  HeadHunter
//
//  Created by Роман Козловский on 03.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - ApiPath

enum ApiPath: String {
    case vacancies = "/vacancies"
}

// MARK: - Config

struct Config {
    
    // MARK: - Private Enum
    
    private enum Key: String {
        case baseUrl
    }
    
    // MARK: - Computed Properties
    
    private var baseUrl: URLComponents {
        get throws {
            guard let baseStringUrl = Bundle.main.infoDictionary?[Key.baseUrl.rawValue] as? String
            else {
                throw APIError.description("Value for key \(Key.baseUrl.rawValue) not found!")
            }
            
            guard let baseUrl = URLComponents(string: baseStringUrl)
            else {
                throw APIError.description("Invalid server URL: \(baseStringUrl)")
            }
            return baseUrl
        }
    }
    
    // MARK: - Public Methods
    
    func getBaseUrl() -> URLComponents {
        return try! baseUrl
    }
}





