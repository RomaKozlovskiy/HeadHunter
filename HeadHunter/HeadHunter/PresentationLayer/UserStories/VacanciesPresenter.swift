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
        vacanciesProvider: VacanciesProvider
    )
    func prepareModelForRequest()
    func fetchVacancies()
    func fetchVacancies(searchText: String, page: Int)
    func fetchAdditionalVacancies(searchText: String, page: Int)
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
    
    func fetchVacancies(searchText: String, page: Int) {
        if searchText.count >= 3 {
            Task { [weak self] in
                guard let strongSelf = self else { return }
                if vacancies == nil {
                    let vacancies = try await vacanciesProvider.fetchVacancies(searchText: searchText, currentPage: page)
                    strongSelf.vacancies = vacancies
                }
                await view?.reloadData()
            }
        }
    }
    
    func fetchAdditionalVacancies(searchText: String, page: Int) {
        guard let vacancies = vacancies else { return }
        if vacancies.items.count < vacancies.pages {
            Task { [weak self] in
                guard let strongSelf = self else { return }
                guard let vacancies = try await vacanciesProvider.fetchVacancies(searchText: searchText, currentPage: page) else { return }
                strongSelf.vacancies?.items.append(contentsOf: vacancies.items)
                strongSelf.vacancies?.page = vacancies.page
                await view?.reloadData()
            }
        }
    }
}
