//
//  Provider.swift
//  HeadHunter
//
//  Created by Роман Козловский on 03.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - ProviderProtocol

protocol ProviderProtocol {
    func request(with route: ApiRoute) async throws -> Data
    func decode<T: Decodable>(_ file: T, data: Data) throws -> T
}

// MARK: - Provider

class Provider: ProviderProtocol {
    
    // MARK: - Public Methods
    
    func request(with route: ApiRoute) async throws -> Data {
        guard let url = route.urlComponents.url else {
            throw RequestProcessingError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func decode<T: Decodable>(_ file: T, data: Data) throws -> T {
        let decoder = JSONDecoder()
        guard let userData = try? decoder.decode(file.self as! T.Type, from: data) else {
            throw RequestProcessingError.failedToDecodeJSON
        }
        return userData
    }
}

