//
//  VacancyCollectionViewCell.swift
//  HeadHunter
//
//  Created by Роман Козловский on 06.12.2023.
//

// MARK: - Import

import UIKit
import SnapKit

// MARK: - VacancyCollectionViewCellDelegate

protocol VacancyCollectionViewCellDelegate: AnyObject {
    func showDetailsButtonDidPressed(at indexPath: Int)
    func favoriteButtonDidPressed(at indexPath: Int, with status: Bool)
}

// MARK: - VacancyCollectionViewCell

final class VacancyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    weak var delegate: VacancyCollectionViewCellDelegate?
    var indexPath: Int?
    
    // MARK: - Private Properties
    
    private lazy var vacancyName: UILabel = _vacancyName
    private lazy var salaryLabel: UILabel = _salaryLabel
    private lazy var vacancyCity: UILabel = _vacancyCity
    private lazy var companyName: UILabel = _companyName
    private lazy var experienceLabel: UILabel = _experienceLabel
    private lazy var companyLogo: UIImageView = _companyLogo
    private lazy var showDetailsButton: UIButton = _showDetailsButton
    private lazy var favoriteButton: UIButton = _favoriteButton
    private var favoriteStatus: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 5, height: 5)
        clipsToBounds = false
    }
    
    override func prepareForReuse() {
        vacancyName.text = nil
        salaryLabel.text = nil
        vacancyCity.text = nil
        companyName.text = nil
        experienceLabel.text = nil
        companyLogo.image = nil
        favoriteButton.tintColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
    }
    // MARK: - Public Methods
    
    func setup(with vacancy: Item?) {
        vacancyName.text = vacancy?.name
        setSalary(from: vacancy)
        vacancyCity.text = vacancy?.address?.city
        companyName.text = vacancy?.employer?.name
        experienceLabel.text = vacancy?.experience?.name
        companyLogo.load(stringUrl: vacancy?.employer?.logoUrls?.original ?? "")
        favoriteStatus = vacancy?.favoriteStatus ?? false
        favoriteButton.tintColor = favoriteStatus ? .systemRed: #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(vacancyName)
        addSubview(salaryLabel)
        addSubview(vacancyCity)
        addSubview(companyName)
        addSubview(experienceLabel)
        addSubview(companyLogo)
        addSubview(showDetailsButton)
        addSubview(favoriteButton)
    }
    
    private func applyConstraints() {
        vacancyName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        salaryLabel.snp.makeConstraints {
            $0.top.equalTo(vacancyName.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        vacancyCity.snp.makeConstraints {
            $0.top.equalTo(salaryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        companyName.snp.makeConstraints {
            $0.top.equalTo(vacancyCity.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        experienceLabel.snp.makeConstraints {
            $0.top.equalTo(companyName.snp.bottom).offset(10)
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
            $0.top.equalTo(favoriteButton.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(70)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(40)
        }
    }
    
    private func setSalary(from vacancy: Item?) {
        let salaryFrom = vacancy?.salary?.from?.salaryFormatting
        let salaryTo = vacancy?.salary?.to?.salaryFormatting
        let currency = vacancy?.salary?.currency?.currencyFormatting
        
        if let salaryFrom = salaryFrom, let salaryTo = salaryTo, salaryFrom == salaryTo, let currency = currency {
            salaryLabel.text = salaryFrom + " " + currency
        } else if let salaryFrom = salaryFrom, salaryFrom != String(0), let salaryTo = salaryTo,
                  let currency = currency, salaryTo != String(0) {
            salaryLabel.text = "от " + salaryFrom + " до " + salaryTo + " " + currency
        }
        else if let salaryFrom = salaryFrom, salaryFrom != String(0), let currency = currency {
            salaryLabel.text = salaryFrom + " " + currency
        } else if let salaryTo = salaryTo, let currency = currency {
            salaryLabel.text = salaryTo + " " + currency
        }
        else {
            salaryLabel.text = "Заработная плата не указана"
        }
    }
    
    @objc private func showDetailsButtonDidPressed() {
        guard let indexPath = indexPath else { return }
        delegate?.showDetailsButtonDidPressed(at: indexPath)
    }
    
    @objc private func favoriteButtonDidPressed() {
        guard let indexPath = indexPath else { return }
        favoriteStatus.toggle()
        favoriteButton.tintColor = favoriteStatus ? .systemRed: #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        delegate?.favoriteButtonDidPressed(at: indexPath, with: favoriteStatus)
    }
}

// MARK: - Private Extension

private extension VacancyCollectionViewCell {
    var _vacancyName: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return result
    }
    
    var _vacancyCity: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyName: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _experienceLabel: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyLogo: UIImageView {
        let result = UIImageView()
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFit
        result.layer.cornerRadius = 70 / 2
        return result
    }
    
    var _showDetailsButton: UIButton {
        let result = UIButton(type: .system)
        result.setTitle("Подробное описание", for: .normal)
        result.setTitleColor(.white, for: .normal)
        result.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        result.backgroundColor = #colorLiteral(red: 0.2972861528, green: 0.6990200281, blue: 0.3044068515, alpha: 1)
        result.layer.cornerRadius = 20
        result.addTarget(self, action: #selector(showDetailsButtonDidPressed), for: .touchUpInside)
        return result
    }
    
    var _favoriteButton: UIButton {
        let result = UIButton(type: .custom)
        result.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        result.tintColor = favoriteStatus ? .systemRed: #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        result.contentVerticalAlignment = .fill
        result.contentHorizontalAlignment = .fill
        result.imageView?.contentMode = .scaleAspectFit
        result.addTarget(self, action: #selector(favoriteButtonDidPressed), for: .touchUpInside)
        return result
    }
}
