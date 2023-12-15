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
            throw APIError.description("Invalid API endpoint: \(route.urlComponents)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.description("API response not HTTP response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.description("Unexpected status code: \(httpResponse.statusCode)")
        }
        return data
    }
    
    func decode<T: Decodable>(_ file: T, data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let userData = try decoder.decode(T.self, from: data)
            return userData
        } catch let error {
            throw APIError.description("Failed to decode JSON, unexpected error: \(error.localizedDescription)")
        }
    }
}

