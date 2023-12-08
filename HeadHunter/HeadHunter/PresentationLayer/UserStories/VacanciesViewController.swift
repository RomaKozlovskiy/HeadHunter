//
//  ViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 01.12.2023.
//

// MARK: - Import

import UIKit
import SnapKit

// MARK: - VacanciesViewProtocol

protocol VacanciesViewProtocol: AnyObject {
    
}

// MARK: - VacanciesViewController

final class VacanciesViewController: UIViewController {
    
    var presenter: VacanciesPresenterProtocol!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addSubviews()
        applyConstraints()
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


// MARK: - VacanciesViewProtocol

extension VacanciesViewController: VacanciesViewProtocol {
    
}

// MARK: - UICollectionViewDataSource

extension VacanciesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: VacancyCollectionViewCell.self), for: indexPath) as! VacancyCollectionViewCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VacanciesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VacanciesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 240)
    }
}
