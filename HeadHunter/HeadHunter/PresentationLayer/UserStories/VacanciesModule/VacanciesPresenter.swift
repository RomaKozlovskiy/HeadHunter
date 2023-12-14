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
    func getFavoriteVacancies() -> [Item?]
    func test()
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
        Task { [weak self] in
            let vacancies = try await vacanciesProvider.fetchVacancies()
            self?.vacancies = vacancies
            await view?.reloadData()
        }
    }
    
    func fetchVacancies(with searchText: String) {
        if searchText.count >= 3 {
            Task { [weak self] in
                guard let strongSelf = self else { return }
                if vacancies == nil {
                    let vacancies = try await vacanciesProvider.fetchVacancies(with: searchText, currentPage: 0)
                    strongSelf.vacancies = vacancies
                }
                await view?.reloadData()
            }
        }
    }
    
    func fetchAdditionalVacancies(with searchText: String) {
        guard let vacancies = vacancies else { return }
        let page = vacancies.page + 1
        if vacancies.items.count < vacancies.pages {
            Task { [weak self] in
                guard let strongSelf = self else { return }
                guard let vacancies = try await vacanciesProvider.fetchVacancies(with: searchText, currentPage: page) else { return }
                strongSelf.vacancies?.items.append(contentsOf: vacancies.items)
                strongSelf.vacancies?.page = vacancies.page
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
    func getFavoriteVacancies() -> [Item?] {
        let favoriteVacancies = favoriteVacanciesStore?.fetchFavoriteVacancies()
        return favoriteVacancies ?? []
    }
    
    func test() {
        guard let favoriteVacancies = favoriteVacanciesStore?.fetchFavoriteVacancies() else { return }
        guard let vacancies = vacancies else { return }
        
        if favoriteVacancies.count != 0 {
            for i in 0...favoriteVacancies.count - 1 {
                
                for j in 0...vacancies.items.count - 1 {
                    if favoriteVacancies[i]?.id == vacancies.items[j].id {
                        print(vacancies.items[j].name)
                        self.vacancies?.items[j].favoriteStatus = true
                    }
                }
            }
        }
        
//        print(self.vacancies?.items.forEach({ item in
//            print(item.favoriteStatus)
//        }))
        guard let vacancies = self.vacancies else { return }
        view?.setupFavoriteStatus(with: vacancies)
    }
}
