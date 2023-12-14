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
    init(view: FavoritesVacanciesViewProtocol,
         favoriteVacanciesStore: FavoriteVacanciesStoreProtocol)
    
    func getFavoriteVacancies() -> [Item?]
}

// MARK: - FavoritesVacanciesPresenter

final class FavoritesVacanciesPresenter: FavoritesVacanciesPresenterProtocol {
    weak var view: FavoritesVacanciesViewProtocol?
    var favoriteVacanciesStore: FavoriteVacanciesStoreProtocol?
    
    init(view: FavoritesVacanciesViewProtocol, favoriteVacanciesStore: FavoriteVacanciesStoreProtocol) {
        self.view = view
        self.favoriteVacanciesStore = favoriteVacanciesStore
    }
    
    func getFavoriteVacancies() -> [Item?] {
         let favoriteVacancies = favoriteVacanciesStore?.fetchFavoriteVacancies()
        return favoriteVacancies ?? []
    }
}

