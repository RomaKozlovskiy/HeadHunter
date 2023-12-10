//
//  VacancyDetailsViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 10.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - VacancyDetailsViewProtocol

protocol VacancyDetailsViewProtocol: AnyObject {
    
}

// MARK: - VacancyDetailsViewController

final class VacancyDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: VacancyDetailsPresenterProtocol!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: - VacancyDetailsViewProtocol Implementation

extension VacancyDetailsViewController: VacancyDetailsViewProtocol {
    
}
