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
         router: RouterProtocol,
         favoriteVacanciesStore: FavoriteVacanciesStoreProtocol)
    
    func getFavoriteVacancies() -> [Item?]
    func setFavoriteVacancy(from vacancy: Item, by status: Bool)
    func showVacancyDetails(with vacancyID: String)
}

// MARK: - FavoritesVacanciesPresenter

final class FavoritesVacanciesPresenter: FavoritesVacanciesPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: FavoritesVacanciesViewProtocol?
    var favoriteVacanciesStore: FavoriteVacanciesStoreProtocol?
    var router: RouterProtocol?
    // MARK: - Init
    
    init(view: FavoritesVacanciesViewProtocol,
         router: RouterProtocol,
         favoriteVacanciesStore: FavoriteVacanciesStoreProtocol) {
        self.view = view
        self.router = router
        self.favoriteVacanciesStore = favoriteVacanciesStore
    }
    
    // MARK: - Public Methods 
    
    func getFavoriteVacancies() -> [Item?] {
         let favoriteVacancies = favoriteVacanciesStore?.fetchFavoriteVacancies()
        return favoriteVacancies ?? []
    }
    
    func setFavoriteVacancy(from vacancy: Item, by status: Bool) {
        if status == true {
            FavoriteVacanciesStore.shared.createFavoriteVacancy(from: vacancy)
        } else if status == false {
            FavoriteVacanciesStore.shared.deleteFavoriteVacancy(by: vacancy.id ?? "")
        }
    }
    
    func showVacancyDetails(with vacancyID: String) {
        router?.presentVacancyDetails(with: vacancyID)
    }
}

