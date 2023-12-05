//
//  RequestProcessingError.swift
//  HeadHunter
//
//  Created by Роман Козловский on 03.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - RequestProcessingError 

enum APIError: Error {
    case description(_: String)
}

// MARK: - Extension RequestProcessingError

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .description(let message):
            return message
        }
    }
}
