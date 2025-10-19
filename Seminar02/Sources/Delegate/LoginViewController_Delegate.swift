//
//  LoginViewController_Delegate.swift
//  Seminar02
//
//  Created by 이명진 on 10/15/25.
//

import UIKit
import Core

public final class LoginViewController_Delegate: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 69, y: 161, width: 236, height: 44))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 18)
        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addPadding()
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        textField.addPadding()
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 21, y: 422, width: 332, height: 58))
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
    }

    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Delegate()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.id = idTextField.text
        welcomeViewController.delegate = self
        self.present(welcomeViewController, animated: true)
    }

    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Delegate()
        welcomeViewController.id = idTextField.text
        welcomeViewController.delegate = self
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }

    @objc
    private func loginButtonDidTap() {
        //        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    
    
}

extension LoginViewController_Delegate: WelcomeReloginDelegate {
    public func retryLogin(didTapReloginWith message: String) {
        titleLabel.text = message
        idTextField.text = ""
        passwordTextField.text = ""
        loginButton.setTitle("다시 로그인하기", for: .normal)
    }
}
