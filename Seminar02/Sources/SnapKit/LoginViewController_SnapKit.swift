//
//  LoginViewController_SnapKit.swift
//  Seminar02
//
//  Created by 이명진 on 10/18/25.
//

import UIKit
import Core
import SnapKit

public final class LoginViewController_SnapKit: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
    }

    private func setUI() {
        self.view.backgroundColor = .white
    }

    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(163)
        }

        idTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        $0.top.equalTo(titleLabel.snp.bottom).offset(71)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
    }

    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_SnapKit()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        self.present(welcomeViewController, animated: true)
    }

    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_SnapKit()
        welcomeViewController.id = idTextField.text
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    @objc
    private func loginButtonDidTap() {
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
}

#Preview {
    let vc = LoginViewController_SnapKit()
    UINavigationController(rootViewController: vc)
}
