//
//  Router.swift
//  HeadHunter
//
//  Created by Роман Козловский on 05.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - RouterProtocol

protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
    
    func showVacancyDetails(with vacancyID: String)
    func presentVacancyDetails(with vacancyID: String)
}

// MARK: - Router

final class Router: RouterProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController?, moduleBuilder: ModuleBuilderProtocol?) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    // MARK: - Public Methods
    
    func showVacancyDetails(with vacancyID: String) {
        if let navigationController = navigationController {
            guard let vacancyDetailsViewController = moduleBuilder?.createVacancyDetailsModule(
                with: vacancyID, router: self)
            else {
                return
            }
            navigationController.pushViewController(vacancyDetailsViewController, animated: true)
        }
    }
    
    func presentVacancyDetails(with vacancyID: String) {
        if let navigationController = navigationController {
            guard let vacancyDetailsViewController = moduleBuilder?.createVacancyDetailsModule(
                with: vacancyID, router: self)
            else {
                return
            }
            navigationController.present(vacancyDetailsViewController, animated: true)
        }
    }
}
