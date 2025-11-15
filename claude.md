# Claude AI 프로젝트 가이드 (th1ngjin)

> Claude가 SOPT-Seminar 프로젝트에서 코드를 작성할 때 따라야 할 규칙과 컨텍스트

---

## 🎯 프로젝트 개요

- **번들 ID**: `com.th1ngjin.*`
- **아키텍처**: Tuist 기반 모듈화 구조
- **배포 방식**: App 타겟 + 전처리기 플래그로 스킴 분기
- **주요 문서**: `TUIST_WORKFLOW_GUIDE.md` (스킴/모듈 추가 시 필독)

---

## 📚 Tech Stack

- **언어**: Swift 5.9+
- **프레임워크**: UIKit, SwiftUI (Seminar05부터)
- **레이아웃**: SnapKit 5.7+ (UIKit), Native SwiftUI Layout (SwiftUI)
- **프로젝트 관리**: Tuist
- **의존성**: Swift Package Manager

---

## 📁 프로젝트 구조

```
SOPT-Seminar/
├── App/                    # 메인 앱 타겟
│   ├── Sources/
│   │   ├── SceneDelegate.swift  # 전처리기로 VC 분기
│   │   └── AppDelegate.swift
│   └── Resources/
├── Core/                   # 공통 유틸리티 (addSubviews 등)
├── Seminar01/              # 1차 세미나 모듈
├── Seminar02/              # 2차 세미나 모듈
├── Seminar03/              # 3차 세미나 모듈
│   ├── Sources/
│   │   ├── TableViewSeminar/
│   │   └── CollectionViewSeminar/
│   └── Resources/
└── Tuist/
    └── ProjectDescriptionHelpers/
        ├── Configuration+Seminar.swift
        ├── Project+Templates.swift
        └── README.md
```

---

## 🛠️ 주요 명령어

- `tuist generate` - Xcode 프로젝트 생성
- `tuist clean` - 캐시 정리
- `tuist edit` - Tuist 매니페스트 편집

---

## 🔧 Tuist 워크플로우 (CRITICAL!)

### 새 스킴 추가 시 (5단계)

1. `Configuration+Seminar.swift`: case 추가
2. `Configuration+Seminar.swift`: compilationFlag 추가
3. `Package.swift`: configuration 추가
4. `SceneDelegate.swift`: #if import & rootViewController 추가
5. `App/Project.swift`: schemes 추가

**상세 가이드**: `TUIST_WORKFLOW_GUIDE.md` 참조

### SceneDelegate 전처리기 패턴 (현재 사용 중!)

```swift
#if SEMINAR01
import Seminar01
#elseif SEMINAR03_CVC
import Seminar03
#endif

// ...

#if SEMINAR01
rootViewController = LoginViewController()
#elseif SEMINAR03_CVC
rootViewController = FeedCollectionViewController()
#endif
```

---

## 📱 UI 코드 작성 규칙

### ✅ UIView 필수 3단계 구조

모든 UIView의 UI 초기화는 다음 3단계 구조를 **반드시** 따릅니다:

```swift
override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()        // 1. 스타일 설정
    setHierarchy() // 2. 뷰 계층 구성
    setLayout()    // 3. 레이아웃 제약조건
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

### ✅ UIViewController 필수 구조

**TableView/CollectionView 사용 시:**

```swift
public override func viewDidLoad() {
    super.viewDidLoad()

    setUI()         // 1. 기본 UI (title, backgroundColor 등)
    register()      // 2. Cell 등록
    setDelegate()   // 3. Delegate/DataSource 설정
    setLayout()     // 4. 레이아웃 (view.addSubview + SnapKit)
    loadMockData()  // 5. 데이터 로드 및 reloadData
}
```

**일반 ViewController:**

```swift
public override func viewDidLoad() {
    super.viewDidLoad()

    setUI()         // 1. 기본 UI 설정
    setHierarchy()  // 2. 뷰 계층 (addSubviews 사용)
    setLayout()     // 3. 레이아웃
}
```

### 1️⃣ setUI()
배경색, 테마, 기본 스타일 등을 설정합니다.

```swift
private func setUI() {
    backgroundColor = .white
    // 기타 스타일 설정
}
```

### 2️⃣ setHierarchy()
Core 모듈의 `addSubviews`를 사용하여 뷰 계층을 구성합니다.

```swift
private func setHierarchy() {
    // ✅ Core 모듈의 addSubviews 활용
    addSubviews(
        titleLabel,
        contentView,
        button
    )
}
```

**❌ 금지:**
```swift
// 이렇게 하나씩 추가하지 말 것
addSubview(titleLabel)
addSubview(contentView)
addSubview(button)
```

### 3️⃣ setLayout()
SnapKit을 사용하여 레이아웃 제약조건을 설정합니다.

```swift
private func setLayout() {
    // ✅ SnapKit 사용
    titleLabel.snp.makeConstraints {
        $0.top.equalTo(safeAreaLayoutGuide).offset(20)
        $0.horizontalEdges.equalToSuperview().inset(20)
    }

    contentView.snp.makeConstraints {
        $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        $0.horizontalEdges.equalToSuperview().inset(20)
    }
}
```

**❌ 금지:**
```swift
// NSLayoutConstraint.activate 사용 금지
NSLayoutConstraint.activate([
    titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
])
```

## 🎨 SnapKit 권장 패턴

### 기본 사용법
```swift
view.snp.makeConstraints {
    $0.top.equalTo(safeAreaLayoutGuide).offset(20)
    $0.horizontalEdges.equalToSuperview().inset(20)  // leading + trailing
    $0.height.equalTo(50)
}
```

### 간결한 표현 사용
- `horizontalEdges` : leading + trailing
- `verticalEdges` : top + bottom
- `edges` : top + leading + bottom + trailing
- `size` : width + height

## 📋 MARK 주석 규칙

UI 관련 클래스는 다음 섹션으로 구분합니다:

```swift
class ExampleView: UIView {

    // MARK: - UI Components
    private let titleLabel: UILabel = { ... }()
    private let button: UIButton = { ... }()

    // MARK: - Initialization
    override init(frame: CGRect) { ... }
    required init?(coder: NSCoder) { ... }

    // MARK: - UI Setup
    private func setUI() { ... }
    private func setHierarchy() { ... }
    private func setLayout() { ... }

    // MARK: - Configuration
    func configure(with data: Model) { ... }
}
```

## 🎯 클래스 정의 규칙

### final 키워드 사용
상속하지 않는 모든 클래스는 `final` 키워드를 **필수**로 사용합니다.

```swift
// ✅ 올바른 예
final class FeedCollectionViewCell: UICollectionViewCell {
    // ...
}

public final class FeedCollectionViewController: UIViewController {
    // ...
}

final class CustomView: UIView {
    // ...
}
```

```swift
// ❌ 잘못된 예 (상속 안 할 거면 final 추가 필요)
class MyCustomView: UIView {
    // ...
}

public class MyViewController: UIViewController {
    // ...
}
```

### UIViewController 컴포넌트 정의
UIViewController에 UI 컴포넌트가 있을 때는 반드시 별도로 정의하고, `// MARK: - UI Components` 주석으로 구분합니다.

```swift
// ✅ 올바른 예
final class ExampleViewController: UIViewController {

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()

    // MARK: - Initialization
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
    }
}
```

```swift
// ❌ 잘못된 예 (컴포넌트 정의 없이 viewDidLoad에서 직접 생성)
final class BadViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()  // ❌ 컴포넌트를 여기서 생성하지 말 것
        view.addSubview(titleLabel)
    }
}
```

## ⚠️ 주의사항

### ❌ 절대 사용 금지
1. `setup~` 메서드명 (예: `setupUI`, `setupLayout`)
   - ✅ 대신 `set~` 사용 (예: `setUI`, `setLayout`)

2. `NSLayoutConstraint.activate`
   - ✅ 대신 SnapKit 사용

3. 개별 `addSubview` 호출
   - ✅ 대신 Core 모듈의 `addSubviews` 사용

4. `translatesAutoresizingMaskIntoConstraints = false` 수동 설정
   - ✅ SnapKit이 자동으로 처리

### ✅ 필수 사항
1. 항상 `setUI()` → `setHierarchy()` → `setLayout()` 순서 유지
2. SnapKit 사용
3. Core 모듈의 `addSubviews` 사용
4. 적절한 MARK 주석 사용

## 📦 의존성

UI 코드 작성 시 필요한 import:

```swift
import UIKit
import SnapKit  // 레이아웃
import Core     // addSubviews 등 유틸리티
```

## 🔄 전체 템플릿

```swift
import UIKit
import SnapKit
import Core

class ExampleView: UIView {

    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setUI() {
        backgroundColor = .white
    }

    private func setHierarchy() {
        addSubviews(
            titleLabel,
            descriptionLabel,
            actionButton
        )
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        actionButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }

    // MARK: - Configuration
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
```

## 🚫 절대 금지 사항 (UIKit)

1. `setup~` 메서드명 (예: setupUI) → `set~` 사용
2. `NSLayoutConstraint.activate` → SnapKit 사용
3. 개별 `addSubview` 호출 → Core의 `addSubviews` 사용
4. 상속하지 않는 클래스에 `final` 키워드 누락
5. UIViewController에서 UI 컴포넌트를 별도 정의 없이 viewDidLoad에서 직접 생성
6. 이모지 사용 (사용자 명시 요청 시에만)
7. 스킴/모듈 추가 시 `TUIST_WORKFLOW_GUIDE.md` 읽지 않기

---

## 🎨 SwiftUI 코드 작성 규칙 (Seminar05+)

### ✅ SwiftUI View 필수 구조

모든 SwiftUI View는 다음 구조를 따릅니다:

```swift
import SwiftUI

struct LoginView: View {

    // MARK: - Properties
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isNavigating: Bool = false

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // UI Components
            }
            .navigationDestination(isPresented: $isNavigating) {
                WelcomeView(username: username)
            }
        }
    }

    // MARK: - View Components
    private var titleView: some View {
        Text("타이틀")
            .font(.title)
            .foregroundColor(.black)
    }

    // MARK: - Actions
    private func loginAction() {
        // 로직 처리
        isNavigating = true
    }
}
```

### SwiftUI 핵심 규칙

1. **struct로 선언** - SwiftUI View는 항상 struct로 선언
2. **View 프로토콜 준수** - `View` 프로토콜 필수 구현
3. **body 프로퍼티** - `var body: some View` 필수
4. **Property Wrappers**:
   - `@State`: View 내부 상태 관리
   - `@Binding`: 부모-자식 간 데이터 바인딩
   - `@StateObject`, `@ObservedObject`: 객체 관찰
5. **MARK 주석**:
   - `// MARK: - Properties`: 상태 및 프로퍼티
   - `// MARK: - Body`: body 프로퍼티
   - `// MARK: - View Components`: 재사용 가능한 뷰 컴포넌트
   - `// MARK: - Actions`: 액션 메서드

### SwiftUI 네비게이션

**NavigationStack 사용 (iOS 16+)**:
```swift
@State private var isNavigating: Bool = false

NavigationStack {
    VStack {
        Button("다음") {
            isNavigating = true
        }
    }
    .navigationDestination(isPresented: $isNavigating) {
        NextView()
    }
}
```

### SwiftUI 레이아웃

**Stack 기반 레이아웃**:
```swift
VStack(spacing: 20) {  // 수직
    Text("제목")
    HStack(spacing: 10) {  // 수평
        Image(systemName: "person")
        Text("사용자")
    }
    ZStack {  // 겹침
        Rectangle()
        Text("오버레이")
    }
}
.padding()
```

### SwiftUI와 UIKit 통합

**UIHostingController로 SwiftUI를 UIKit에 통합**:
```swift
// SceneDelegate.swift
#if SEMINAR05
import SwiftUI
import Seminar05

let swiftUIView = LoginView_SwiftUI()
rootViewController = UIHostingController(rootView: swiftUIView)
#endif
```

### SwiftUI 스타일링

```swift
Text("제목")
    .font(.system(size: 18, weight: .bold))
    .foregroundColor(.black)
    .padding()
    .background(Color.orange)
    .cornerRadius(8)
```

## 🚫 절대 금지 사항 (SwiftUI)

1. class로 View 선언 → struct 사용
2. UIKit의 setUI/setHierarchy/setLayout 패턴 사용 금지
3. SnapKit 사용 금지 → SwiftUI native layout 사용
4. @State를 var로 선언 → @State private var 사용
5. 이모지 사용 (사용자 명시 요청 시에만)

---

## 💡 헬퍼 함수 (Project+Templates.swift)

### 모듈 생성
```swift
Project.framework(name: "Seminar04", dependencies: [...])
```

### 스킴 생성
```swift
createSeminarScheme(number: 4)
createCustomScheme(name: "Seminar04CVC", configurationName: "Seminar04CVC")
```

---

## ⚡️ 빠른 참조

| 작업 | 명령어/함수 |
|------|-------------|
| 프로젝트 생성 | `tuist generate` |
| Framework 모듈 | `Project.framework(name:dependencies:)` |
| 세미나 스킴 | `createSeminarScheme(number:)` |
| 커스텀 스킴 | `createCustomScheme(name:configurationName:)` |
| 뷰 추가 | `addSubviews(view1, view2)` |
| 레이아웃 | `view.snp.makeConstraints { ... }` |

---

## 📝 작업 전 체크리스트

- [ ] 스킴/모듈 추가인가? → `TUIST_WORKFLOW_GUIDE.md` 읽기
- [ ] UI 코드인가? → 3단계 구조 확인
- [ ] 다른 모듈에서 사용? → `public` 접근 제어
- [ ] 작업 후 → `tuist generate` 테스트

---

**작성자**: th1ngjin
**최종 업데이트**: 2025-10-28
**버전**: 2.0
