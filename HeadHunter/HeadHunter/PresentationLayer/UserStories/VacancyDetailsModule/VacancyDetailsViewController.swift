//
//  VacancyDetailsViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 10.12.2023.
//

// MARK: - Import

import UIKit

// MARK: - VacancyDetailsViewProtocol

protocol VacancyDetailsViewProtocol: AnyObject {
    
}

// MARK: - VacancyDetailsViewController

final class VacancyDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: VacancyDetailsPresenterProtocol!
    
    // MARK: - Private UI Properties
    
    private lazy var scrollView: UIScrollView = _scrollView
    private lazy var contentView: UIView = _contentView
    private lazy var yStackView: UIStackView = _yStackView
    private lazy var xStackView: UIStackView = _xStackView
    private lazy var vacancyName: UILabel = _vacancyName
    private lazy var experienceLabel: UILabel = _experienceLabel
    private lazy var employmentScheduleLabel: UILabel = _employmentScheduleLabel
    private lazy var companyName: UILabel = _companyName
    private lazy var cityName: UILabel = _cityName
    private lazy var descriptionLabel: UILabel = _descriptionLabel
    private lazy var companyLogo: UIImageView = _companyLogo

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        applyConstraints()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(yStackView)
        yStackView.addArrangedSubview(vacancyName)
        yStackView.addArrangedSubview(experienceLabel)
        yStackView.addArrangedSubview(employmentScheduleLabel)
        yStackView.addArrangedSubview(xStackView)
        yStackView.addArrangedSubview(cityName)
        yStackView.addArrangedSubview(descriptionLabel)
        xStackView.addArrangedSubview(companyName)
        xStackView.addArrangedSubview(companyLogo)
    }
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(16)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        yStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        companyLogo.snp.makeConstraints{
            $0.height.width.equalTo(70)
        }
    }
}

// MARK: - VacancyDetailsViewProtocol Implementation

extension VacancyDetailsViewController: VacancyDetailsViewProtocol {
    
}

// MARK: - Private Extension

private extension VacancyDetailsViewController {
    var _scrollView: UIScrollView {
        let result = UIScrollView()
        result.showsVerticalScrollIndicator = false
        return result
    }
    
    var _contentView: UIView {
        let result = UIView()
        return result
    }

    var _yStackView: UIStackView {
        let result = UIStackView()
        result.axis = .vertical
        result.distribution = .fill
        result.spacing = 10
        return result
    }
    
    var _xStackView: UIStackView {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fill
        result.alignment = .center
        result.spacing = 10
        return result
    }
    
    var _vacancyName: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return result
    }
    
    var _experienceLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _employmentScheduleLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyName: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return result
    }
    
    var _cityName: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return result
    }
    
    var _descriptionLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return result
    }
    
    var _companyLogo: UIImageView {
        let result = UIImageView()
        result.contentMode = .scaleAspectFit
        result.layer.cornerRadius = 70 / 2
        result.clipsToBounds = true
        return result
    }
}
