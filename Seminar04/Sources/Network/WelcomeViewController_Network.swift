//
//  WelcomeViewController_Network.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import UIKit
import SnapKit
import Core

public final class WelcomeViewController_Network: BaseViewController {
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "환영합니다!"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "새로운 이름"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "새로운 이메일"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "새로운 나이"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var getUserButton: UIButton = {
        let button = createButton(
            title: "개인정보 조회 (GET /api/v1/users/{id})",
            color: .systemBlue
        )
        button.addTarget(self, action: #selector(getUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var updateUserButton: UIButton = {
        let button = createButton(
            title: "개인정보 수정 (PATCH /api/v1/users/{id})",
            color: .systemOrange
        )
        button.addTarget(self, action: #selector(updateUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteUserButton: UIButton = {
        let button = createButton(
            title: "회원탈퇴 (DELETE /api/v1/users/{id})",
            color: .systemRed
        )
        button.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private let userId: Int
    private let userName: String
    private let provider: NetworkProviding
    private var currentUser: UserResponse?
    
    // MARK: - Init
    
    public init(
        userId: Int,
        userName: String,
        provider: NetworkProviding = NetworkProvider()
    ) {
        self.userId = userId
        self.userName = userName
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        updateUserInfoLabel()
    }
    
    // MARK: - UI Setup
    
    private func setHierarchy() {
        
        view.addSubviews(
            titleLabel,
            userInfoLabel,
            nameTextField,
            emailTextField,
            ageTextField,
            getUserButton,
            updateUserButton,
            deleteUserButton
        )
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        ageTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        getUserButton.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        updateUserButton.snp.makeConstraints {
            $0.top.equalTo(getUserButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        deleteUserButton.snp.makeConstraints {
            $0.top.equalTo(updateUserButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func updateUserInfoLabel() {
        if let user = currentUser {
            userInfoLabel.text = """
            User ID: \(user.id)
            Username: \(user.username)
            Name: \(user.name)
            Email: \(user.email)
            Age: \(user.age)
            Status: \(user.status)
            """
        } else {
            userInfoLabel.text = """
            User ID: \(userId)
            Name: \(userName)
            
            '개인정보 조회' 버튼을 눌러
            전체 정보를 확인하세요!
            """
        }
    }
    
    // MARK: - Actions
    
    @objc private func getUserButtonTapped() {
        Task {
            await performGetUser()
        }
    }

    @objc private func updateUserButtonTapped() {
        Task {
            await performUpdateUser()
        }
    }
    
    @objc private func deleteUserButtonTapped() {
        showDeleteConfirmation()
    }
    
    // MARK: - Network Methods (Swift Concurrency!)
    
    /// 개인정보 조회 API 호출
    @MainActor
    private func performGetUser() async {
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performGetUser(
                id: userId,
                provider: provider
            )
            
            currentUser = response
            updateUserInfoLabel()
            
            showAlert(
                title: "조회 성공",
                message: "개인정보를 성공적으로 조회했습니다!"
            )
        } catch let error as NetworkError {
            print("🚨 [GetUser Error] \(error.detailedDescription)")
            showAlert(title: "조회 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [GetUser Unknown Error] \(error)")
            showAlert(title: "조회 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    /// 개인정보 수정 API 호출
    @MainActor
    private func performUpdateUser() async {
        let newName = nameTextField.text?.isEmpty == false ? nameTextField.text : nil
        let newEmail = emailTextField.text?.isEmpty == false ? emailTextField.text : nil
        let newAge = ageTextField.text.flatMap { Int($0) }
        
        guard newName != nil || newEmail != nil || newAge != nil else {
            showAlert(
                title: "입력 오류",
                message: "수정할 정보를 하나 이상 입력해주세요."
            )
            return
        }
        
        loadingIndicator.startAnimating()
        
        do {
            let response = try await UserAPI.performUpdateUser(
                id: userId,
                name: newName,
                email: newEmail,
                age: newAge,
                provider: provider
            )
            
            currentUser = response
            updateUserInfoLabel()
            
            // 입력 필드 초기화
            nameTextField.text = ""
            emailTextField.text = ""
            ageTextField.text = ""
            
            showAlert(
                title: "수정 성공",
                message: "개인정보가 성공적으로 수정되었습니다!"
            )
        } catch let error as NetworkError {
            print("🚨 [UpdateUser Error] \(error.detailedDescription)")
            showAlert(title: "수정 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [UpdateUser Unknown Error] \(error)")
            showAlert(title: "수정 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    /// 회원탈퇴 API 호출
    @MainActor
    private func performDeleteUser() async {
        loadingIndicator.startAnimating()
        
        do {
            _ = try await UserAPI.performDeleteUser(
                id: userId,
                provider: provider
            )
            
            showAlert(
                title: "탈퇴 완료",
                message: "회원탈퇴가 완료되었습니다."
            ) { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
        } catch let error as NetworkError {
            print("🚨 [DeleteUser Error] \(error.detailedDescription)")
            showAlert(title: "탈퇴 실패", message: error.localizedDescription)
        } catch {
            print("🚨 [DeleteUser Unknown Error] \(error)")
            showAlert(title: "탈퇴 실패", message: error.localizedDescription)
        }
        
        loadingIndicator.stopAnimating()
    }
    
    // MARK: - Helpers
    // TODO: 추후 분리
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 8
        return button
    }
    
    
    private func showDeleteConfirmation() {
        let alert = UIAlertController(
            title: "회원탈퇴",
            message: "정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "탈퇴", style: .destructive) { [weak self] _ in
            Task {
                await self?.performDeleteUser()
            }
        })
        
        present(alert, animated: true)
    }
}
