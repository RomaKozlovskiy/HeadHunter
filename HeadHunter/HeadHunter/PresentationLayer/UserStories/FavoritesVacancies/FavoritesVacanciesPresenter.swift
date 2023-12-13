//
//  FavoritesVacanciesPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - FavoritesVacanciesPresenterProtocol

protocol FavoritesVacanciesPresenterProtocol: AnyObject {
    init(view: FavoritesVacanciesViewProtocol)
}

// MARK: - FavoritesVacanciesPresenter

final class FavoritesVacanciesPresenter: FavoritesVacanciesPresenterProtocol {
    weak var view: FavoritesVacanciesViewProtocol?
    
    init(view: FavoritesVacanciesViewProtocol) {
        self.view = view
    }
}
