//
//  Extension + String.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - Extension String

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var currencyFormatting: String? {
        var currency = self
        switch currency {
        case "RUR":
            currency = currency.replacingOccurrences(of: currency, with: "RUB")
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = currency
            if let currencySymbol = formatter.currencySymbol {
                return currencySymbol
            }
        default:
            return currency
        }
        return nil
    }
}
