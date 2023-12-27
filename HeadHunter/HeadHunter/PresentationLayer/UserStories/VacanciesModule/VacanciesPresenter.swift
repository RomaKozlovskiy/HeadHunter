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
    var vacancies: Vacancies? { get set }
    init(
        view: VacanciesViewProtocol,
        router: RouterProtocol,
        vacanciesProvider: VacanciesProvider,
        favoriteVacanciesStore: FavoriteVacanciesStoreProtocol
    )
    func prepareModelForRequest()
    func fetchVacancies()
    func fetchVacancies(with searchText: String)
    func fetchAdditionalVacancies(with searchText: String)
    func showVacancyDetails(with vacancyID: String)
    func setFavoriteVacancy(from vacancy: Item, by status: Bool)
    func setFavoriteStatus()
}

// MARK: - VacanciesPresenter

final class VacanciesPresenter: VacanciesPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: VacanciesViewProtocol?
    var router: RouterProtocol?
    let vacanciesProvider: VacanciesProvider!
    var vacancies: Vacancies?
    var favoriteVacanciesStore: FavoriteVacanciesStoreProtocol?
    
    // MARK: - Init
    
    required init(
        view: VacanciesViewProtocol,
        router: RouterProtocol,
        vacanciesProvider: VacanciesProvider,
        favoriteVacanciesStore: FavoriteVacanciesStoreProtocol) {
            self.view = view
            self.router = router
            self.vacanciesProvider = vacanciesProvider
            self.favoriteVacanciesStore = favoriteVacanciesStore
        }
    
    // MARK: - Public Methods
    
    func prepareModelForRequest() {
        if vacancies != nil {
            vacancies = nil
        }
    }
    
    func fetchVacancies() {
        Task {
            let vacancies = try await vacanciesProvider.fetchVacancies()
            self.vacancies = vacancies
            await view?.reloadData()
        }
    }
    
    func fetchVacancies(with searchText: String) {
        if searchText.count >= 3 {
            Task {
                if vacancies == nil {
                    let vacancies = try await vacanciesProvider.fetchVacancies(with: searchText, currentPage: 0)
                    self.vacancies = vacancies
                }
                await view?.reloadData()
            }
        }
    }
    
    func fetchAdditionalVacancies(with searchText: String) {
        guard let vacancies = vacancies else { return }
        let page = vacancies.page + 1
        if vacancies.items.count < vacancies.pages {
            Task {
                guard let vacancies = try await vacanciesProvider.fetchVacancies(with: searchText, currentPage: page) else { return }
                self.vacancies?.items.append(contentsOf: vacancies.items)
                self.vacancies?.page = vacancies.page
                await view?.reloadData()
            }
        }
    }
    
    func showVacancyDetails(with vacancyID: String) {
        router?.showVacancyDetails(with: vacancyID)
    }
    
    func setFavoriteVacancy(from vacancy: Item, by status: Bool) {
        if status == true {
            FavoriteVacanciesStore.shared.createFavoriteVacancy(from: vacancy)
        } else if status == false {
            FavoriteVacanciesStore.shared.deleteFavoriteVacancy(by: vacancy.id ?? "")
        }
    }
    
    func setFavoriteStatus() {
        guard let favoriteVacancies = favoriteVacanciesStore?.fetchFavoriteVacancies(),
              favoriteVacancies.count != 0 else { return }
        guard let vacancies = vacancies else { return }
        for i in 0...favoriteVacancies.count - 1 {
            for j in 0...vacancies.items.count - 1 {
                if favoriteVacancies[i]?.id == vacancies.items[j].id {
                    self.vacancies?.items[j].favoriteStatus = true
                }
            }
        }
    }
}
