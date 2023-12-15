//
//  TabBarController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - TabBarController

final class TabBarController: UITabBarController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        setupSearchController()
    }
    
    // MARK: - Public Methods
    
    func setup(with vacanciesViewController: UIViewController, and favoritesViewController: UIViewController) {
        vacanciesViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vacanciesViewController.tabBarItem.title = "Поиск"
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        favoritesViewController.tabBarItem.title = "Избранное"
        viewControllers = [vacanciesViewController, favoritesViewController]
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

