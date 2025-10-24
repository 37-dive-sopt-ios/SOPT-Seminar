# Seminar03 - MVC 패턴

## 📚 개요
이 모듈은 iOS 개발에서 가장 기본적인 디자인 패턴인 **MVC (Model-View-Controller)** 패턴을 학습하기 위한 예제입니다.

## 🎯 학습 목표
- MVC 패턴의 각 구성요소 이해
- Model, View, Controller의 역할과 책임 구분
- Massive View Controller 문제점 인식

## 📁 프로젝트 구조

```
Seminar03/
├── Sources/
│   ├── MVC/
│   │   ├── UserModel.swift          # Model: 데이터 & 비즈니스 로직
│   │   └── UserView.swift           # View: UI 표시
│   └── Seminar03ViewController.swift # Controller: 중재자
└── README.md
```

## 🔍 MVC 패턴 구성요소

### Model (UserModel.swift)
- **역할**: 데이터와 비즈니스 로직 담당
- **책임**:
  - 데이터 구조 정의
  - 데이터 변환 로직 (예: `introduction`, `isAdult`)
- **특징**: View나 Controller에 대해 알 필요가 없음

```swift
struct UserModel {
    let name: String
    let age: Int
    let hobby: String

    var introduction: String {
        return "\(name)님은 \(age)살이고, \(hobby)을/를 좋아합니다."
    }

    var isAdult: Bool {
        return age >= 20
    }
}
```

### View (UserView.swift)
- **역할**: 사용자에게 보여지는 UI 담당
- **책임**:
  - UI 컴포넌트 배치 및 스타일링
  - Model 데이터를 화면에 표시
  - 사용자 입력 받기
- **특징**: 비즈니스 로직을 포함하지 않음

```swift
class UserView: UIView {
    // UI 컴포넌트들
    private let nameLabel: UILabel
    private let ageLabel: UILabel
    let updateButton: UIButton

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()        // 스타일 설정
        setHierarchy() // 뷰 계층 구성
        setLayout()    // 레이아웃 제약조건
    }

    private func setUI() {
        backgroundColor = .white
    }

    private func setHierarchy() {
        // Core 모듈의 addSubviews 활용
        addSubviews(nameLabel, ageLabel, updateButton)
    }

    private func setLayout() {
        // SnapKit으로 깔끔한 레이아웃
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }

    // View는 데이터를 어떻게 표시할지만 알면 됨
    func configure(with user: UserModel) {
        nameLabel.text = "이름: \(user.name)"
        ageLabel.text = "나이: \(user.age)세"
    }
}
```

### Controller (Seminar03ViewController.swift)
- **역할**: Model과 View 사이의 중재자
- **책임**:
  - View로부터 사용자 입력을 받아 Model 업데이트
  - Model의 데이터 변경을 View에 반영
  - 앱의 흐름 제어
- **특징**: Model과 View를 연결하는 접착제 역할

```swift
class Seminar03ViewController: UIViewController {
    private var userModel: UserModel  // Model
    private let userView = UserView()  // View

    private func setupView() {
        // Model의 데이터를 View에 전달
        userView.configure(with: userModel)
    }

    @objc private func updateButtonTapped() {
        // Model 업데이트
        userModel = newUser
        // View 업데이트
        userView.configure(with: userModel)
    }
}
```

## ✅ MVC 패턴의 장점

1. **역할 분리가 명확함**
   - 각 구성요소의 책임이 분명하게 구분됨
   - 코드의 가독성 향상

2. **이해하기 쉬움**
   - 직관적인 구조로 초보자도 쉽게 이해 가능
   - Apple이 기본으로 제공하는 패턴

3. **유지보수 용이**
   - Model만 수정하면 데이터 로직 변경 가능
   - View만 수정하면 UI 변경 가능

## ⚠️ MVC 패턴의 단점

### Massive View Controller 문제

iOS에서 ViewController가 View의 생명주기까지 관리하다 보니, Controller에 너무 많은 책임이 몰리는 경향이 있습니다.

**문제점**:
- Controller가 비대해지기 쉬움 (수백~수천 줄)
- View와 Controller가 강하게 결합됨
- 테스트하기 어려움
- 재사용성 저하

**해결책**:
- MVVM (Model-View-ViewModel) 패턴
- VIPER 패턴
- Clean Architecture
- View Controller를 작은 단위로 분리

## 🚀 실행 방법

### 1. 프로젝트 생성
```bash
tuist install
tuist generate
```

### 2. Xcode에서 스킴 선택
- Xcode를 열고 스킴을 **Seminar03MVC**로 선택

### 3. 빌드 및 실행
- Cmd + R 또는 상단의 Run 버튼 클릭

## 🎨 예제 기능

이 예제 앱은 사용자 정보를 표시하고 변경하는 간단한 기능을 제공합니다:

1. **초기 화면**: 김솝트님의 정보 표시
2. **버튼 클릭**: 랜덤으로 다른 사용자 정보로 변경
   - 이애플 (23세, 디자인)
   - 박구글 (28세, 코딩)
   - 최페이스북 (30세, 네트워킹)
3. **성인 여부 확인**: 콘솔에 성인 여부 출력

## 🛠 Tuist 스킴 설정

새로운 스킴을 추가할 때는 다음 파일들을 수정해야 합니다:

### 1. Package.swift
```swift
let packageSettings = PackageSettings(
    productTypes: ["SnapKit": .framework],
    baseSettings: .settings(
        configurations: [
            .debug(name: "Seminar03MVC"),  // 추가
            // ...
        ]
    )
)
```

### 2. Tuist/ProjectDescriptionHelpers/Project+Templates.swift
```swift
public let sharedConfigurations: [Configuration] = [
    .debug(name: .configuration("Seminar03MVC")),  // 추가
    // ...
]
```

### 3. App/Project.swift
```swift
// Configuration 추가
settings: .settings(
    configurations: [
        .debug(name: .configuration("Seminar03MVC"),
               settings: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS": "SEMINAR03_MVC"]),
    ]
)

// Scheme 추가
schemes: [
    .scheme(
        name: "Seminar03MVC",
        shared: true,
        buildAction: .buildAction(targets: ["App"]),
        runAction: .runAction(
            configuration: .configuration("Seminar03MVC"),
            executable: "App"
        )
    )
]
```

### 4. App/Sources/SceneDelegate.swift
```swift
// Import 추가
#elseif SEMINAR03_MVC
import Seminar03

// rootViewController 분기처리
#elseif SEMINAR03_MVC
rootViewController = Seminar03ViewController()
```

### 5. 프로젝트 재생성
```bash
tuist install
tuist generate
```

## 📝 주의사항

- **새 스킴 추가 시 꼭 4개 파일 모두 수정해야 함**
  - Package.swift
  - Project+Templates.swift
  - App/Project.swift
  - SceneDelegate.swift

- **tuist install을 먼저 실행해야 함**
  - 외부 의존성(SnapKit 등)이 제대로 인식되지 않으면 빌드 에러 발생

- **빌드 실패 시 체크리스트**
  1. `tuist install` 실행했는지 확인
  2. `tuist generate` 실행했는지 확인
  3. Package.swift에 configuration 추가했는지 확인
  4. SceneDelegate에 분기처리 추가했는지 확인

## 📚 참고 자료

- [Apple - Model-View-Controller](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
- [iOS Architecture Patterns](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52)

## 👨‍💻 작성자
- SOPT iOS 세미나

---

**다음 단계**: MVVM 패턴으로 Massive ViewController 문제 해결하기
