//
//  VacancyCollectionViewCell.swift
//  HeadHunter
//
//  Created by Роман Козловский on 06.12.2023.
//

// MARK: - Import

import UIKit
import SnapKit

// MARK: - VacancyCollectionViewCell

final class VacancyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private lazy var vacancyTitle: UILabel = _vacancyTitle
    private lazy var salaryLabel: UILabel = _salaryLabel
    private lazy var vacancyCity: UILabel = _vacancyCity
    private lazy var companyTitle: UILabel = _companyTitle
    private lazy var scheduleLabel: UILabel = _scheduleLabel
    private lazy var companyLogo: UIImageView = _companyLogo
    private lazy var showDetailsButton: UIButton = _showDetailsButton
    private lazy var favoriteButton: UIButton = _favoriteButton
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addSubviews() {
        addSubview(vacancyTitle)
        addSubview(salaryLabel)
        addSubview(vacancyCity)
        addSubview(companyTitle)
        addSubview(scheduleLabel)
        addSubview(companyLogo)
        addSubview(showDetailsButton)
        addSubview(favoriteButton)
    }
    
    func applyConstraints() {
        vacancyTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        salaryLabel.snp.makeConstraints {
            $0.top.equalTo(vacancyTitle.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        vacancyCity.snp.makeConstraints {
            $0.top.equalTo(salaryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        companyTitle.snp.makeConstraints {
            $0.top.equalTo(vacancyCity.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(companyTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        showDetailsButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        companyLogo.snp.makeConstraints {
            $0.top.equalTo(vacancyTitle.snp.bottom)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(50)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(40)
        }
    }
}

// MARK: - Private Extension

private extension VacancyCollectionViewCell {
    var _vacancyTitle: UILabel {
        let result = UILabel()
        result.text = "Продавец-консультант (насосное оборудование)"
        result.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        result.numberOfLines = 2
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.text = "до 40 000 RUB"
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 21, weight: .black)
        result.adjustsFontForContentSizeCategory = true
        return result
    }
    
    var _vacancyCity: UILabel {
        let result = UILabel()
        result.text = "Ростов-на-Дону"
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyTitle: UILabel {
        let result = UILabel()
        result.text = "Яндекс Крауд"
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _scheduleLabel: UILabel {
        let result = UILabel()
        result.text = "Полный день"
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyLogo: UIImageView {
        let result = UIImageView()
        result.image = UIImage(systemName: "paperplane.fill")
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFit
        result.layer.cornerRadius = 50 / 2
        return result
    }
    
    var _showDetailsButton: UIButton {
        let result = UIButton(type: .system)
        result.setTitle("Подробное описание", for: .normal)
        result.setTitleColor(.white, for: .normal)
        result.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        result.backgroundColor = #colorLiteral(red: 0.2972861528, green: 0.6990200281, blue: 0.3044068515, alpha: 1)
        result.layer.cornerRadius = 20
        return result
    }
    
    var _favoriteButton: UIButton {
        let result = UIButton(type: .custom)
        result.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        result.tintColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        result.contentVerticalAlignment = .fill
        result.contentHorizontalAlignment = .fill
        result.imageView?.contentMode = .scaleAspectFit
        return result
    }
}
