//
//  ViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 01.12.2023.
//

// MARK: - Import

import UIKit
import SnapKit

// MARK: - VacanciesViewProtocol

protocol VacanciesViewProtocol: AnyObject {
    
}

// MARK: - VacanciesViewController

final class VacanciesViewController: UIViewController {
    
    var presenter: VacanciesPresenterProtocol!
    let vacanciesCollectionView = VacanciesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(vacanciesCollectionView)
        vacanciesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Extension VacanciesViewController

extension VacanciesViewController: VacanciesViewProtocol {
    
}
