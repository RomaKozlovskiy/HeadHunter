//
//  Extension  + Int.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import 

import Foundation

// MARK: - Extension Int

extension Int {
    var salaryFormatting: String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        let formattedNumber = formatter.string(from: NSNumber(value: self)) ?? ""
        return formattedNumber
    }
}
