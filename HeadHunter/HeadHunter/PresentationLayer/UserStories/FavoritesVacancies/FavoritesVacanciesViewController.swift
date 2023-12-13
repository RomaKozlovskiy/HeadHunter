//
//  FavoritesVacanciesViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - FavoritesVacanciesViewProtocol

protocol FavoritesVacanciesViewProtocol: AnyObject {
    
}

// MARK: - FavoritesVacanciesViewController

final class FavoritesVacanciesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: FavoritesVacanciesPresenterProtocol!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
 
// MARK: - FavoritesVacanciesViewProtocol Implementation

extension FavoritesVacanciesViewController: FavoritesVacanciesViewProtocol {
    
}
