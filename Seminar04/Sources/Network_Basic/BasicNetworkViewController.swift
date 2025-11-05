//
//  BasicNetworkViewController.swift
//  Seminar04
//
//  Created by 이명진 on 11/03/25.
//
//  📚 학습 목표: Service 클래스를 사용한 네트워크 통신
//  - ViewController는 UI만 담당 (View)
//  - UserService는 네트워크만 담당 (Model)
//  - 책임 분리 (Separation of Concerns)

import UIKit
import Core
import SnapKit

public final class BasicNetworkViewController: BaseViewController {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 네트워크 통신"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.text = "lee"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.text = "Q1w2!!!!"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
        textField.text = "mj"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.text = "test123@naver.com"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()

    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이"
        textField.text = "29"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입 (POST)", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        return button
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 (POST)", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        return button
    }()

    private let getUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("유저 조회 (GET)", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        return button
    }()

    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 8
        textView.isEditable = false
        textView.text = "결과가 여기에 표시됩니다."
        return textView
    }()

    // MARK: - Properties

    /// UserService 인스턴스 (네트워크 통신 담당)
    private let userService = UserService()

    /// 회원가입/로그인 후 저장된 사용자 ID
    private var userId: Int?

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setActions()
    }

    // MARK: - UI Setup

    private func setUI() {
        view.backgroundColor = .white
        title = "Basic Network (Service 분리)"
    }

    private func setHierarchy() {
        view.addSubviews(
            titleLabel,
            usernameTextField,
            passwordTextField,
            nameTextField,
            emailTextField,
            ageTextField,
            registerButton,
            loginButton,
            getUserButton,
            resultTextView
        )
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }

        registerButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        getUserButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        resultTextView.snp.makeConstraints {
            $0.top.equalTo(getUserButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }

    private func setActions() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        getUserButton.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func registerButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let ageText = ageTextField.text, let age = Int(ageText) else {
            showAlert(title: "입력 오류", message: "모든 필드를 입력해주세요.")
            return
        }

        performRegister(username: username, password: password, name: name, email: email, age: age)
    }

    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "아이디와 비밀번호를 입력해주세요.")
            return
        }

        performLogin(username: username, password: password)
    }

    @objc private func getUserButtonTapped() {
        guard let userId = userId else {
            showAlert(title: "오류", message: "먼저 로그인하거나 회원가입을 해주세요.")
            return
        }

        performGetUser(id: userId)
    }

    // MARK: - Network Methods (UserService 사용!)

    /// 📌 1. 회원가입
    /// UserService의 register 메서드를 호출하고 결과를 받아서 UI 업데이트
    private func performRegister(username: String, password: String, name: String, email: String, age: Int) {
        startLoading()

        // UserService에게 회원가입 요청
        userService.register(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        ) { [weak self] result in
            // ⚠️ completion은 background thread에서 실행되므로 UI 업데이트는 main thread로!
            DispatchQueue.main.async {
                self?.stopLoading()

                switch result {
                case .success(let userId):
                    // 성공: 사용자 ID 저장하고 결과 표시
                    self?.userId = userId
                    self?.showResult(
                        success: true,
                        message: "회원가입 성공!\nUser ID: \(userId)"
                    )

                case .failure(let error):
                    // 실패: 에러 메시지 표시
                    if case .message(let errorMessage) = error {
                        self?.showResult(
                            success: false,
                            message: "회원가입 실패\n\(errorMessage)"
                        )
                    }
                }
            }
        }
    }

    /// 📌 2. 로그인
    /// UserService의 login 메서드를 호출하고 결과를 받아서 UI 업데이트
    private func performLogin(username: String, password: String) {
        startLoading()

        // UserService에게 로그인 요청
        userService.login(
            username: username,
            password: password
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.stopLoading()

                switch result {
                case .success(let userId):
                    // 성공: 사용자 ID 저장하고 결과 표시
                    self?.userId = userId
                    self?.showResult(
                        success: true,
                        message: "로그인 성공!\nUser ID: \(userId)"
                    )

                case .failure(let error):
                    // 실패: 에러 메시지 표시
                    if case .message(let errorMessage) = error {
                        self?.showResult(
                            success: false,
                            message: "로그인 실패\n\(errorMessage)"
                        )
                    }
                }
            }
        }
    }

    /// 📌 3. 유저 조회
    /// UserService의 getUser 메서드를 호출하고 결과를 받아서 UI 업데이트
    private func performGetUser(id: Int) {
        startLoading()

        // UserService에게 유저 조회 요청
        userService.getUser(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.stopLoading()

                switch result {
                case .success(let userData):
                    // 성공: 사용자 정보 파싱해서 표시
                    let username = userData["username"] as? String ?? ""
                    let name = userData["name"] as? String ?? ""
                    let email = userData["email"] as? String ?? ""
                    let age = userData["age"] as? Int ?? 0

                    let message = """
                    유저 조회 성공!

                    ID: \(id)
                    Username: \(username)
                    Name: \(name)
                    Email: \(email)
                    Age: \(age)
                    """

                    self?.showResult(success: true, message: message)

                case .failure(let error):
                    // 실패: 에러 메시지 표시
                    if case .message(let errorMessage) = error {
                        self?.showResult(
                            success: false,
                            message: "조회 실패\n\(errorMessage)"
                        )
                    }
                }
            }
        }
    }

    // MARK: - Helper

    /// 결과를 TextView에 표시
    private func showResult(success: Bool, message: String) {
        let emoji = success ? "✅" : "❌"
        resultTextView.text = "\(emoji) \(message)"
        resultTextView.textColor = success ? .systemGreen : .systemRed
    }
}
