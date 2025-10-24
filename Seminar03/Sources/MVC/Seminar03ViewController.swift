import UIKit
import Core

// MARK: - Controller
/// MVC의 C (Controller)
/// - Model과 View 사이의 중재자 역할
/// - View로부터 사용자 입력을 받아 Model을 업데이트
/// - Model의 데이터 변경을 View에 반영
/// - 앱의 흐름을 제어하는 로직 포함
///
/// ⚠️ Massive View Controller 문제
/// - iOS에서 Controller가 View의 생명주기까지 관리하다보니
///   Controller에 너무 많은 책임이 몰리는 경향이 있음
/// - 이를 해결하기 위해 MVVM, VIPER 등의 패턴이 등장
public class Seminar03ViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Model
    private var userModel: UserModel = UserModel(
        name: "김솝트",
        age: 25,
        hobby: "iOS 개발"
    )
    
    private let userView = UserView()
    
    // MARK: - Life Cycle
    
    public override func loadView() {
        self.view = userView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Controller는 View와 Model을 연결
        setView()
        setAddTarget()
    }
    
    // MARK: - Setup
    private func setView() {
        // Model의 데이터를 View에 전달
        userView.configure(with: userModel)
    }
    
    private func setAddTarget() {
        // View의 사용자 입력을 받아서 처리
        userView.updateButton.addTarget(
            self,
            action: #selector(updateButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    @objc private func updateButtonTapped() {
        // 사용자 입력에 따라 Model 업데이트
        let users = [
            UserModel(name: "이애플", age: 23, hobby: "디자인"),
            UserModel(name: "박구글", age: 28, hobby: "코딩"),
            UserModel(name: "최페이스북", age: 30, hobby: "네트워킹")
        ]
        
        // 랜덤으로 사용자 변경
        userModel = users.randomElement()!
        
        // Model이 변경되면 View를 업데이트
        userView.configure(with: userModel)
        
        // 성인인지 확인하는 비즈니스 로직은 Model에 있음
        if userModel.isAdult {
            print("✅ \(userModel.name)님은 성인입니다.")
        }
    }
}

/*
 📝 MVC 패턴 정리
 
 [Model] - 데이터 & 비즈니스 로직
 └─ UserModel.swift
 - 데이터 구조 정의
 - 데이터 변환 로직 (introduction, isAdult)
 
 [View] - UI 표시
 └─ UserView.swift
 - 화면에 보이는 UI 컴포넌트
 - 데이터를 어떻게 보여줄지만 결정
 - 로직은 포함하지 않음
 
 [Controller] - 중재자
 └─ Seminar03ViewController.swift
 - Model과 View를 연결
 - 사용자 입력 처리
 - 앱 흐름 제어
 
 ✅ 장점:
 - 역할 분리가 명확함
 - 이해하기 쉬움
 - Apple이 기본으로 제공하는 패턴
 
 ⚠️ 단점:
 - Controller가 너무 비대해지기 쉬움 (Massive ViewController)
 - View와 Controller가 강하게 결합됨
 - 테스트하기 어려움
 */
