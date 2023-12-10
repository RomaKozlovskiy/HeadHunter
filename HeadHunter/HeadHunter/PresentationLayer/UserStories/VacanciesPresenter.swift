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
    func fetchVacancies(with searchText: String)
    func fetchAdditionalVacancies(with searchText: String)
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
}
