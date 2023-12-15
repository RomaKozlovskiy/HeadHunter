//
//  Extension + UIImageView.swift
//  HeadHunter
//
//  Created by Роман Козловский on 07.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - Extension UIImageView

extension UIImageView {
    func load(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

