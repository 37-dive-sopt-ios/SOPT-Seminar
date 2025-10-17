//
//  LoginViewController_AutoLayout.swift
//  Seminar01
//
//  Created by 이명진 on 10/18/25.
//

import UIKit
import Core

public final class LoginViewController_AutoLayout: UIViewController {

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
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     titleLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 163)])
        
        NSLayoutConstraint.activate([idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     idTextField.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 71),
                                     idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     idTextField.heightAnchor.constraint(equalToConstant: 52),])

        
        NSLayoutConstraint.activate([passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTextField.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 130),
                                     passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     passwordTextField.heightAnchor.constraint(equalToConstant: 52),])

        
        NSLayoutConstraint.activate([loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
                                     loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                     loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                     loginButton.heightAnchor.constraint(equalToConstant: 58)])
    }

    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_AutoLayout()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        self.present(welcomeViewController, animated: true)
    }

    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_AutoLayout()
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
    let vc = LoginViewController_AutoLayout()
    UINavigationController(rootViewController: vc)
}
