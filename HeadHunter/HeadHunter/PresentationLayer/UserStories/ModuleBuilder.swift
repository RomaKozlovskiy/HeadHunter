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
    func createVacanciesModule(with router: RouterProtocol, and tabBar: TabBarController) -> UIViewController
    func createVacancyDetailsModule(with vacancyID: String, router: RouterProtocol) -> UIViewController
    func createFavoritesVacanciesModule(router: RouterProtocol) -> UIViewController
}

// MARK: - ModuleBuilder

final class ModuleBuilder: ModuleBuilderProtocol {
    func createVacanciesModule(with router: RouterProtocol, and tabBar: TabBarController) -> UIViewController {
        let view = VacanciesViewController()
        let vacanciesProvider = VacanciesProvider()
        let favoritesVacanciesStore = FavoriteVacanciesStore.shared
        let presenter = VacanciesPresenter(
            view: view,
            router: router,
            vacanciesProvider: vacanciesProvider,
            favoriteVacanciesStore: favoritesVacanciesStore
        )
        view.presenter = presenter
        view.tabBar = tabBar
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
    
    func createFavoritesVacanciesModule(router: RouterProtocol) -> UIViewController {
        let view = FavoritesVacanciesViewController()
        let favoriteVacanciesStore = FavoriteVacanciesStore.shared
        let presenter = FavoritesVacanciesPresenter(view: view, router: router, favoriteVacanciesStore: favoriteVacanciesStore)
        view.presenter = presenter
        return view
    }
}

