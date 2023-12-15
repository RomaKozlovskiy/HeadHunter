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
    @MainActor
    func showVacancyDetails(_ vacancyDetails: VacancyDetails)
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
    private lazy var salaryLabel: UILabel = _salaryLabel
    private lazy var experienceLabel: UILabel = _experienceLabel
    private lazy var employmentScheduleLabel: UILabel = _employmentScheduleLabel
    private lazy var companyName: UILabel = _companyName
    private lazy var cityName: UILabel = _cityName
    private lazy var professionalRole: UILabel = _professionalRole
    private lazy var descriptionLabel: UILabel = _descriptionLabel
    private lazy var companyLogo: UIImageView = _companyLogo
    private lazy var leftSpacerView: UIView = UIView()
    private lazy var rightSpacerView: UIView = UIView()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490196109, blue: 0.9490196109, alpha: 1)
        addSubviews()
        applyConstraints()
        presenter.fetchVacancyDetails()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        xStackView.layer.cornerRadius = 10
        xStackView.layer.shadowRadius = 5
        xStackView.layer.shadowOpacity = 0.1
        xStackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        xStackView.clipsToBounds = false
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(yStackView)
        yStackView.addArrangedSubview(vacancyName)
        yStackView.addArrangedSubview(salaryLabel)
        yStackView.addArrangedSubview(experienceLabel)
        yStackView.addArrangedSubview(employmentScheduleLabel)
        yStackView.addArrangedSubview(xStackView)
        yStackView.addArrangedSubview(cityName)
        yStackView.addArrangedSubview(professionalRole)
        yStackView.addArrangedSubview(descriptionLabel)
        xStackView.addArrangedSubview(leftSpacerView)
        xStackView.addArrangedSubview(companyName)
        xStackView.addArrangedSubview(companyLogo)
        xStackView.addArrangedSubview(rightSpacerView)
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
    
        companyLogo.snp.makeConstraints {
            $0.width.height.equalTo(100)
        }
        leftSpacerView.snp.makeConstraints {
            $0.width.equalTo(10)        }
        
        rightSpacerView.snp.makeConstraints {
            $0.width.equalTo(10)
        }
    }
    
    private func setSalary(from vacancyDetails: VacancyDetails?) {
        let salaryFrom = vacancyDetails?.salary?.from?.salaryFormatting
        let salaryTo = vacancyDetails?.salary?.to?.salaryFormatting
        let currency = vacancyDetails?.salary?.currency?.currencyFormatting

        if let salaryFrom = salaryFrom, let salaryTo = salaryTo, let currency = currency {
            salaryLabel.text = "от " + salaryFrom + " до " + salaryTo + " " + currency
        } else if salaryFrom != nil && currency != nil {
            salaryLabel.text = salaryFrom! + " " + currency!
        } else {
            salaryLabel.text = "Заработная плата не указана"
        }
    }
}

// MARK: - VacancyDetailsViewProtocol Implementation

extension VacancyDetailsViewController: VacancyDetailsViewProtocol {
    func showVacancyDetails(_ vacancyDetails: VacancyDetails) {
        vacancyName.text = vacancyDetails.name
        setSalary(from: vacancyDetails)
        experienceLabel.text = "Требуемый опыт: " + (vacancyDetails.experience?.name ?? "")
        employmentScheduleLabel.text = (vacancyDetails.employment?.name)! + ", " + (vacancyDetails.schedule?.name)!
        companyName.text = vacancyDetails.employer?.name
        cityName.text = vacancyDetails.address?.raw
        professionalRole.text = vacancyDetails.professionalRole[0]?.name
        descriptionLabel.text = vacancyDetails.description.htmlToAttributedString?.string
        companyLogo.load(stringUrl: vacancyDetails.employer?.logoUrls?.original ?? "")
    }
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
        result.alignment = .center
        result.distribution = .fill
        result.layer.cornerRadius = 10
        result.spacing = 10
        result.backgroundColor = .white
        return result
    }
    
    var _vacancyName: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return result
    }
    
    var _experienceLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _employmentScheduleLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return result
    }
    
    var _companyName: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        return result
    }
    
    var _cityName: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return result
    }
    
    var _professionalRole: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
        result.layer.cornerRadius = 100 / 2
        result.clipsToBounds = true
        return result
    }
}
