//
//  ViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 01.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - VacanciesViewProtocol

protocol VacanciesViewProtocol: AnyObject {
    
}

// MARK: - VacanciesViewController

class VacanciesViewController: UIViewController {
    
    var presenter: VacanciesPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
}

// MARK: - Extension VacanciesViewController

extension VacanciesViewController: VacanciesViewProtocol {
    
}
