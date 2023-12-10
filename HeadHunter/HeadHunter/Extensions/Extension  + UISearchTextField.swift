//
//  Extension + UISearchTextField.swift
//  HeadHunter
//
//  Created by Роман Козловский on 08.12.2023.
//

// MARK: - Import

import UIKit
import Combine

// MARK: - Extension UISearchTextField

extension UISearchTextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UISearchTextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}

