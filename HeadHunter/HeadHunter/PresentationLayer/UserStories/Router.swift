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
    
    func initialViewController()
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
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let vacanciesViewController = moduleBuilder?.createVacanciesModule(router: self) else {
                return
            }
            navigationController.viewControllers = [vacanciesViewController]
        }
    }
}