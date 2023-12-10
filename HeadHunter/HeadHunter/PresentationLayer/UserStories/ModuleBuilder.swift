//
//  ModuleBuilder.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - ModuleBuilderProtocol

protocol ModuleBuilderProtocol: AnyObject {
    func createVacanciesModule(router: RouterProtocol) -> UIViewController
    func createVacancyDetailsModule(
        with vacancyID: String,
        router: RouterProtocol) -> UIViewController
}

// MARK: - ModuleBuilder

final class ModuleBuilder: ModuleBuilderProtocol {
    func createVacanciesModule(router: RouterProtocol) -> UIViewController {
        let view = VacanciesViewController()
        let vacanciesProvider = VacanciesProvider()
        let presenter = VacanciesPresenter(
            view: view,
            router: router,
            vacanciesProvider: vacanciesProvider
        )
        view.presenter = presenter
        return view
    }
    
    func createVacancyDetailsModule(
        with vacancyID: String,
        router: RouterProtocol) -> UIViewController {
            let view = VacancyDetailsViewController()
            let vacancyDetailsProvider = VacancyDetailsProvider()
            let presenter = VacancyDetailsPresenter(
                view: view,
                vacancyDetailsProvider: vacancyDetailsProvider,
                vacancyID: vacancyID
            )
            view.presenter = presenter
            return view
        }
}

