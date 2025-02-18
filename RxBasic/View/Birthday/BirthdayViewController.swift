//
//  BirthdayViewController.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class BirthdayViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let birthDayPicker = UIDatePicker()
    private let infoLabel = UILabel()
    private let containerStackView = UIStackView()
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let dayLabel = UILabel()
    private let nextButton = PointButton(title: "가입하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureView()
        bind()
    }
    
    private func bind() {
        
    }
}

extension BirthdayViewController {
    private func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        yearLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        monthLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        dayLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "Birthday"
        
        birthDayPicker.datePickerMode = .date
        birthDayPicker.preferredDatePickerStyle = .wheels
        birthDayPicker.locale = Locale(identifier: "ko-KR")
        birthDayPicker.maximumDate = Date()
        
        infoLabel.textColor = .black
        infoLabel.text = "만 17세 이상만 가입 가능합니다."
        
        containerStackView.axis = .horizontal
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 10
        
        yearLabel.text = "2023년"
        yearLabel.textColor = .black

        monthLabel.text = "33월"
        monthLabel.textColor = .black

        dayLabel.text = "99일"
        dayLabel.textColor = .black

    }
}
