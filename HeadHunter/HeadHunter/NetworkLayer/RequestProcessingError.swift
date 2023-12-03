//
//  RequestProcessingError.swift
//  HeadHunter
//
//  Created by Роман Козловский on 03.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - RequestProcessingError 

enum RequestProcessingError: Error {
    case invalidBaseUrl
    case invalidUrl
    case failedToDecodeJSON
}

// MARK: - Extension RequestProcessingError

extension RequestProcessingError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidBaseUrl:
            return "INVALID OR MISSING BASE URL!"
        case .invalidUrl:
            return "INVALID OR MISSING URL!"
        case .failedToDecodeJSON:
            return "FAILED TO DECODE JSON!"
        }
    }
}
