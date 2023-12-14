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

// MARK: - VacancyCollectionViewCellDelegate

protocol VacancyCollectionViewCellDelegate: AnyObject {
    func showDetailsButtonDidPressed(at indexPath: Int)
    func favoriteButtonDidPressed(at indexPath: Int, with status: Bool)
}

// MARK: - VacanciesViewController

final class VacanciesViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var tabBar: TabBarController?
    var presenter: VacanciesPresenterProtocol!
    private var collectionView: UICollectionView!
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addSubviews()
        applyConstraints()
        listenForSearchTextChanges()
        presenter.fetchVacancies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
        tabBar?.searchController.searchBar.searchTextField.textPublisher()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { (searchText) in
                self.presenter.prepareModelForRequest()
                self.presenter.fetchVacancies(with: searchText)
            }
            .store(in: &cancellabels)
    }
}


// MARK: - VacanciesViewProtocol Implementation

extension VacanciesViewController: VacanciesViewProtocol {
    func reloadData() {
        presenter.setFavoriteStatus()
        collectionView.reloadData()
    }
}

// MARK: - VacancyCollectionViewCellDelegate Implementation

extension VacanciesViewController: VacancyCollectionViewCellDelegate {
    func showDetailsButtonDidPressed(at indexPath: Int) {
        guard let vacancyID = presenter.vacancies?.items[indexPath].id else { return }
        presenter.showVacancyDetails(with: vacancyID)
    }
    
    func favoriteButtonDidPressed(at indexPath: Int, with status: Bool) {
        presenter.vacancies?.items[indexPath].favoriteStatus = status
        guard let vacancy = presenter.vacancies?.items[indexPath] else { return }
        presenter.setFavoriteVacancy(from: vacancy, by: status)
    }
}

// MARK: - UICollectionViewDataSource

extension VacanciesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.vacancies?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VacancyCollectionViewCell.self), for: indexPath) as! VacancyCollectionViewCell
        cell.delegate = self
        cell.indexPath = indexPath.row
        let vacancy = presenter.vacancies?.items[indexPath.row]
        cell.setup(with: vacancy)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VacanciesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vacancyID = presenter.vacancies?.items[indexPath.row].id else { return }
        presenter.showVacancyDetails(with: vacancyID)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let vacancies = presenter.vacancies else { return }
        if indexPath.row == vacancies.items.count - 5 {
            guard let searchText = tabBar?.searchController.searchBar.searchTextField.text else { return }
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
