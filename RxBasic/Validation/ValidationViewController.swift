//
//  ValidationViewController.swift
//  RxBasic
//
//  Created by 조우현 on 2/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ValidationViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let usernameLabel = UILabel()
    private let usernameTextField = UITextField()
    private let usernameValidationLabel = UILabel()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidationLabel = UILabel()
    private let signInButton = UIButton()
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bind()
    }

    private func bind() {
        let usernameValid = usernameTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, value in
                value.count >= owner.minimalUsernameLength
            }
            .share(replay: 1) // share(replay:)의 의미는?
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, value in
            value.count >= owner.minimalPasswordLength
            }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        // username의 유효성이 password TF의 isEnabled의 상태와 같도록 함
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert(message: "회원가입 성공!") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension ValidationViewController {
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "Simple Validation"
        
        [usernameLabel, usernameTextField, usernameValidationLabel, passwordLabel, passwordTextField, passwordValidationLabel, signInButton].forEach { view.addSubview($0) }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(30)
        }
        
        usernameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(30)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        usernameLabel.text = "Username"
        usernameLabel.font = .systemFont(ofSize: 17)
        usernameTextField.borderStyle = .roundedRect
        usernameValidationLabel.text = "Username은 최소 \(minimalUsernameLength)글자 이상이어야 합니다"
        usernameValidationLabel.font = .systemFont(ofSize: 17)
        usernameValidationLabel.textColor = .red
        
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 17)
        passwordTextField.borderStyle = .roundedRect
        passwordValidationLabel.text = "Username은 최소 \(minimalPasswordLength)글자 이상이어야 합니다"
        passwordValidationLabel.font = .systemFont(ofSize: 17)
        passwordValidationLabel.textColor = .red
        
        signInButton.backgroundColor = .systemTeal
        signInButton.setTitle("회원가입", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitleColor(.lightGray, for: .disabled)
        signInButton.layer.cornerRadius = 10
    }
}
