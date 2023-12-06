//
//  VacanciesPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacanciesPresenterProtocol

protocol VacanciesPresenterProtocol: AnyObject {
    init(
        view: VacanciesViewProtocol,
        router: RouterProtocol,
        vacanciesProvider: VacanciesProvider
    )
}

// MARK: - VacanciesPresenter

final class VacanciesPresenter: VacanciesPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: VacanciesViewProtocol?
    var router: RouterProtocol?
    let vacanciesProvider: VacanciesProvider!
    var vacancies: Vacancies?
    
    // MARK: - Init
    
    required init(
        view: VacanciesViewProtocol,
        router: RouterProtocol,
        vacanciesProvider: VacanciesProvider) {
            self.view = view
            self.router = router
            self.vacanciesProvider = vacanciesProvider
        }
}
