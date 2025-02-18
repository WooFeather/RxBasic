//
//  NumbersViewController.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NumbersViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let firstNumberTextField = UITextField()
    private let secondNumberTextField = UITextField()
    private let thirdNumberTextField = UITextField()
    private let plusLabel = UILabel()
    private let lineView = UIView()
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        bind()
    }
    
    private func bind() {
        // 3개의 옵저버블을 한번에 처리
        // zip과 다른점은 한 개의 옵저버블이 변해도 전체가 방출됨
        Observable.combineLatest(firstNumberTextField.rx.text.orEmpty, secondNumberTextField.rx.text.orEmpty, thirdNumberTextField.rx.text.orEmpty) {
            firstTextValue, secondTextValue, thirdTextValue -> Int in
            // 여기서 Int로 타입변환시 옵셔널처리는 이게 최선인가?
            return (Int(firstTextValue) ?? 0) + (Int(secondTextValue) ?? 0) + (Int(thirdTextValue) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
}

extension NumbersViewController {
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "Adding Numbers"
        
        [firstNumberTextField, secondNumberTextField, thirdNumberTextField, plusLabel, lineView, resultLabel].forEach { view.addSubview($0) }
        
        firstNumberTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        secondNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNumberTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        thirdNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(secondNumberTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(thirdNumberTextField.snp.leading).offset(-12)
            make.centerY.equalTo(thirdNumberTextField)
            make.height.equalTo(21)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(thirdNumberTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(21)
        }
        
        firstNumberTextField.borderStyle = .roundedRect
        secondNumberTextField.borderStyle = .roundedRect
        thirdNumberTextField.borderStyle = .roundedRect
        
        firstNumberTextField.keyboardType = .decimalPad
        secondNumberTextField.keyboardType = .decimalPad
        thirdNumberTextField.keyboardType = .decimalPad
        
        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 17)
        
        lineView.backgroundColor = .lightGray
        
        resultLabel.textAlignment = .right
    }
}
