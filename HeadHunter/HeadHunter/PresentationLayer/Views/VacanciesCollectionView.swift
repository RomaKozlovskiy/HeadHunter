//
//  VacanciesCollectionView.swift
//  HeadHunter
//
//  Created by Роман Козловский on 06.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - VacanciesCollectionView

final class VacanciesCollectionView: UICollectionView {
    
    // MARK: - Init
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        register(VacancyCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: VacancyCollectionViewCell.self))
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension VacanciesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: VacancyCollectionViewCell.self), for: indexPath) as! VacancyCollectionViewCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension VacanciesCollectionView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VacanciesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 240)
    }
}
