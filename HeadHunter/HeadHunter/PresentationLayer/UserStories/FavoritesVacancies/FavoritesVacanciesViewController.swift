//
//  FavoritesVacanciesViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 11.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - FavoritesVacanciesViewProtocol

protocol FavoritesVacanciesViewProtocol: AnyObject {
    
}

// MARK: - FavoritesVacanciesViewController

final class FavoritesVacanciesViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: FavoritesVacanciesPresenterProtocol!
    private var collectionView: UICollectionView!

    var favoriteVacancies: [Item?] {
        presenter.getFavoriteVacancies()
    }
        
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupCollectionView()
        addSubviews()
        applyConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        collectionView.reloadData()
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
}
 
// MARK: - FavoritesVacanciesViewProtocol Implementation

extension FavoritesVacanciesViewController: FavoritesVacanciesViewProtocol {
    
}

// MARK: - UICollectionViewDataSource

extension FavoritesVacanciesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVacancies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VacancyCollectionViewCell.self), for: indexPath) as! VacancyCollectionViewCell
        cell.indexPath = indexPath.row
        cell.delegate = self
        let favoriteVacancy = favoriteVacancies[indexPath.row]
        cell.setup(with: favoriteVacancy)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritesVacanciesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vacancy = favoriteVacancies[indexPath.row]?.id else { return }
        presenter.showVacancyDetails(with: vacancy)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesVacanciesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 240)
    }
}

// MARK: - VacancyCollectionViewCellDelegate

extension FavoritesVacanciesViewController: VacancyCollectionViewCellDelegate {
    func showDetailsButtonDidPressed(at indexPath: Int) {
        guard let vacancy = favoriteVacancies[indexPath]?.id else { return }
        presenter.showVacancyDetails(with: vacancy)
    }
    
    func favoriteButtonDidPressed(at indexPath: Int, with status: Bool) {
        guard let vacancy = favoriteVacancies[indexPath] else { return }
        presenter.setFavoriteVacancy(from: vacancy, by: status)
        collectionView.reloadData()
    }
    
    
}
