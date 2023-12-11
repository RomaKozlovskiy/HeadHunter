//
//  VacancyDetailsPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 10.12.2023.
//

// MARK: - Import

import Foundation

// MARK: - VacancyDetailsPresenterProtocol

protocol VacancyDetailsPresenterProtocol: AnyObject {
    init(
        view: VacancyDetailsViewProtocol,
        vacancyDetailsProvider: VacancyDetailsProvider,
        vacancyID: String
    )
    
    func fetchVacancyDetails()
}

// MARK: - VacancyDetailsPresenter

final class VacancyDetailsPresenter: VacancyDetailsPresenterProtocol {
  
    // MARK: - Properties
    
    weak var view: VacancyDetailsViewProtocol?
    var vacancyDetailsProvider: VacancyDetailsProvider!
    var vacancyDetails: VacancyDetails?
    var vacancyID: String?
    
    // MARK: - Init
    
    init(
        view: VacancyDetailsViewProtocol,
        vacancyDetailsProvider: VacancyDetailsProvider,
        vacancyID: String) {
            self.view = view
            self.vacancyDetailsProvider = vacancyDetailsProvider
            self.vacancyID = vacancyID
    }
    
    func fetchVacancyDetails() {
        Task {
            guard let vacancyID = vacancyID else { return }
            guard let vacancyDetails = try await vacancyDetailsProvider.fetchDetailedVacancy(by: vacancyID) else { return }
            await view?.showVacancyDetails(vacancyDetails)
        }
    }
}

