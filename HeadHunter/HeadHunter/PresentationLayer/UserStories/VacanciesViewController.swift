//
//  ViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 01.12.2023.
//

// MARK: - Import

import UIKit
import SnapKit
import Combine

// MARK: - VacanciesViewProtocol

protocol VacanciesViewProtocol: AnyObject {
    @MainActor
    func reloadData()
}

// MARK: - VacanciesViewController

final class VacanciesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: VacanciesPresenterProtocol!
    private var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupCollectionView()
        addSubviews()
        applyConstraints()
        listenForSearchTextChanges()
        presenter.fetchVacancies()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(VacancyCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: VacancyCollectionViewCell.self))
    }
    
    private func listenForSearchTextChanges() {
        searchController.searchBar.searchTextField.textPublisher()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { (searchText) in
                self.presenter.prepareModelForRequest()
                self.presenter.fetchVacancies(with: searchText)
            }
            .store(in: &cancellabels)
    }
}


// MARK: - VacanciesViewProtocol

extension VacanciesViewController: VacanciesViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension VacanciesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.vacancies?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VacancyCollectionViewCell.self), for: indexPath) as! VacancyCollectionViewCell
        let vacancies = presenter.vacancies
        cell.setup(with: vacancies, at: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VacanciesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let vacancies = presenter.vacancies else { return }
        if indexPath.row == vacancies.items.count - 5 {
            guard let searchText = searchController.searchBar.searchTextField.text else { return }
            presenter.fetchAdditionalVacancies(with: searchText)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VacanciesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 240)
    }
}
