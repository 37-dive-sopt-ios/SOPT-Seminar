//
//  LoginViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 10/8/25.
//

import UIKit
import Core

public final class LoginViewController: UIViewController {

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
        textField.addPadding()
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
        
        self.view.addSubviews(
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton
        )
    }

    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        self.present(welcomeViewController, animated: true)
    }

    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.id = idTextField.text
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    @objc
    private func loginButtonDidTap() {
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
}
