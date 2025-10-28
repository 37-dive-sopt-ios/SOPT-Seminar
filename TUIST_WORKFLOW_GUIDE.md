# 🚀 Tuist 워크플로우 가이드 (th1ngjin)

> **목적**: Claude가 재부팅되어도 이 문서를 읽고 즉시 스킴/모듈을 추가할 수 있도록!

---

## 📋 현재 프로젝트 구조

### 핵심 정보
- **번들 ID 프리픽스**: `com.th1ngjin`
- **구조**: App 타겟에서 전처리기로 분기 처리
- **SceneDelegate**: 전처리기 플래그로 ViewController 분기

### 폴더 구조
```
SOPT-Seminar/
├── App/                    # 메인 앱 (모든 스킴의 진입점)
│   └── Sources/
│       └── SceneDelegate.swift  # 👈 전처리기 분기 처리
├── Core/                   # 공통 유틸리티
├── Seminar01/              # 1차 세미나 모듈
├── Seminar02/              # 2차 세미나 모듈
├── Seminar03/              # 3차 세미나 모듈
│   ├── Sources/
│   │   ├── TableViewSeminar/
│   │   └── CollectionViewSeminar/
└── Tuist/
    └── ProjectDescriptionHelpers/
        ├── Configuration+Seminar.swift  # Configuration 설정
        ├── Project+Templates.swift      # 헬퍼 함수들
        └── README.md                    # 사용법
```

---

## 🎯 스킴 추가하는 방법

### Step 1: Configuration 추가

**파일**: `Tuist/ProjectDescriptionHelpers/Configuration+Seminar.swift`

```swift
public enum SeminarConfig: String, CaseIterable {
    case seminar01 = "Seminar01"
    case seminar03CVC = "Seminar03CVC"
    case seminar04 = "Seminar04"  // 👈 여기에 추가!

    var compilationFlag: String {
        switch self {
        case .seminar04:
            return "SEMINAR04"  // 👈 플래그 추가!
        }
    }
}
```

### Step 2: Package.swift 업데이트

**파일**: `Package.swift`

```swift
baseSettings: .settings(
    configurations: [
        .debug(name: "Seminar04"),  // 👈 여기에 추가!
        .debug(name: "Debug"),
        .release(name: "Release")
    ]
)
```

### Step 3: SceneDelegate 분기 추가

**파일**: `App/Sources/SceneDelegate.swift`

#### 3-1. Import 추가
```swift
#if SEMINAR01
import Seminar01
#elseif SEMINAR04  // 👈 추가!
import Seminar04
#endif
```

#### 3-2. ViewController 분기 추가
```swift
#if SEMINAR01
rootViewController = LoginViewController()
#elseif SEMINAR04  // 👈 추가!
rootViewController = Seminar04ViewController()
#else
rootViewController = DefaultViewController()
#endif
```

### Step 4: App/Project.swift에 스킴 추가

**파일**: `App/Project.swift`

```swift
schemes: [
    createSeminarScheme(number: 1),
    createSeminarScheme(number: 2),
    createSeminarScheme(number: 3),
    createSeminarScheme(number: 4),  // 👈 추가! (자동으로 Seminar04 스킴 생성)

    // 또는 커스텀 스킴
    createCustomScheme(
        name: "Seminar04Custom",
        configurationName: "Seminar04"
    )
]
```

### Step 5: tuist generate 실행

```bash
tuist generate
```

---

## 📦 모듈 추가하는 방법

### Step 1: 모듈 폴더 생성

```bash
mkdir -p Seminar04/Sources
mkdir -p Seminar04/Resources
```

### Step 2: Project.swift 생성

**파일**: `Seminar04/Project.swift`

```swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Seminar04",
    dependencies: [
        .project(target: "Core", path: "../Core"),
        .external(name: "SnapKit")
    ]
)
```

### Step 3: Workspace.swift에 추가

**파일**: `Workspace.swift`

```swift
let workspace = Workspace(
    name: "SOPT-Seminar",
    projects: [
        "App",
        "Core",
        "Seminar01",
        "Seminar02",
        "Seminar03",
        "Seminar04"  // 👈 추가!
    ]
)
```

### Step 4: App/Project.swift dependencies 추가

**파일**: `App/Project.swift`

```swift
dependencies: [
    .project(target: "Core", path: "../Core"),
    .project(target: "Seminar01", path: "../Seminar01"),
    .project(target: "Seminar02", path: "../Seminar02"),
    .project(target: "Seminar03", path: "../Seminar03"),
    .project(target: "Seminar04", path: "../Seminar04")  // 👈 추가!
]
```

### Step 5: ViewController 작성

**파일**: `Seminar04/Sources/Seminar04ViewController.swift`

```swift
import UIKit
import Core
import SnapKit

public final class Seminar04ViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Seminar 04"
    }
}
```

### Step 6: tuist generate 실행

```bash
tuist generate
```

---

## 🔥 빠른 작업 체크리스트

### 새 스킴 추가 (예: Seminar04)

- [ ] `Configuration+Seminar.swift`: case 추가
- [ ] `Configuration+Seminar.swift`: compilationFlag 추가
- [ ] `Package.swift`: configuration 추가
- [ ] `SceneDelegate.swift`: #if import 추가
- [ ] `SceneDelegate.swift`: #if rootViewController 추가
- [ ] `App/Project.swift`: schemes 추가
- [ ] `tuist generate` 실행

### 새 모듈 추가 (예: Seminar04)

- [ ] 폴더 생성: `mkdir -p Seminar04/Sources`
- [ ] `Seminar04/Project.swift` 생성
- [ ] `Workspace.swift`: projects 추가
- [ ] `App/Project.swift`: dependencies 추가
- [ ] ViewController 작성
- [ ] 위의 "새 스킴 추가" 체크리스트 따르기
- [ ] `tuist generate` 실행

---

## 💡 자주 사용하는 패턴

### 패턴 1: 세미나 번호로 스킴 추가

```swift
// App/Project.swift
schemes: [
    createSeminarScheme(number: 4)  // Seminar04 자동 생성
]
```

**자동으로 생성되는 것:**
- 스킴 이름: `Seminar04`
- Configuration: `Seminar04`
- Compilation Flag: `SEMINAR04`

### 패턴 2: 같은 모듈에 여러 스킴

```swift
// Configuration+Seminar.swift
case seminar03 = "Seminar03"
case seminar03MVC = "Seminar03MVC"
case seminar03ChatList = "Seminar03ChatList"
case seminar03CVC = "Seminar03CVC"

// App/Project.swift
schemes: [
    createCustomScheme(name: "Seminar03MVC", configurationName: "Seminar03MVC"),
    createCustomScheme(name: "Seminar03ChatList", configurationName: "Seminar03ChatList"),
    createCustomScheme(name: "Seminar03CVC", configurationName: "Seminar03CVC")
]

// SceneDelegate.swift
#elseif SEMINAR03_MVC
rootViewController = LoginViewController_CustomView()
#elseif SEMINAR03_CHATLIST
rootViewController = ChatViewController()
#elseif SEMINAR03_CVC
rootViewController = FeedCollectionViewController()
```

### 패턴 3: 환경별 앱 분리 (선택사항)

```swift
// 독립적인 테스트 앱이 필요할 때
let project = Project(
    name: "TestApp",
    targets: [
        .appTarget(
            name: "TestApp",
            bundleId: "com.th1ngjin.test",
            configuration: .debug,
            dependencies: [
                .project(target: "Seminar04", path: "../Seminar04")
            ]
        )
    ]
)
```

---

## 🛠️ 헬퍼 함수 정리

### 모듈 생성
- `Project.framework(name:dependencies:)` - Framework 모듈
- `Project.appTarget(...)` - 앱 타겟 (독립 앱용)

### 스킴 생성
- `createSeminarScheme(number:)` - 세미나 번호로 자동 생성
- `createSeminarClosureScheme(number:)` - 클로저 스킴
- `createCustomScheme(name:configurationName:targetName:)` - 자유 커스텀
- `createEnvironmentScheme(environment:appName:...)` - DEV/QA/PROD

---

## 🚨 주의사항

1. **Configuration 이름 != 스킴 이름**이 될 수 있음
   - Configuration: `Seminar03CVC`
   - 스킴: `Seminar03CVC` (보통 같지만 달라도 OK)

2. **Compilation Flag는 언더스코어 사용**
   - Configuration: `Seminar03CVC`
   - Flag: `SEMINAR03_CVC`

3. **모든 Configuration은 3곳에 추가**
   - `Configuration+Seminar.swift`
   - `Package.swift`
   - `SceneDelegate.swift`

4. **Public 접근 제어**
   - 다른 모듈에서 사용할 클래스/함수는 `public` 필수!

5. **tuist generate는 항상 마지막에**
   - 모든 설정 완료 후 한번에 실행

---

## 📝 실전 예제

### 예제: Seminar04 CollectionView 추가하기

#### 1. 모듈 생성
```bash
mkdir -p Seminar04/Sources/CollectionView
```

#### 2. Configuration 추가
```swift
// Configuration+Seminar.swift
case seminar04CVC = "Seminar04CVC"

var compilationFlag: String {
    case .seminar04CVC: return "SEMINAR04_CVC"
}
```

#### 3. Package.swift
```swift
.debug(name: "Seminar04CVC")
```

#### 4. 모듈 Project.swift
```swift
// Seminar04/Project.swift
let project = Project.framework(
    name: "Seminar04",
    dependencies: [
        .project(target: "Core", path: "../Core"),
        .external(name: "SnapKit")
    ]
)
```

#### 5. ViewController 작성
```swift
// Seminar04/Sources/CollectionView/MyCollectionViewController.swift
public final class MyCollectionViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    // ...
}
```

#### 6. SceneDelegate
```swift
#elseif SEMINAR04_CVC
import Seminar04

// ...

#elseif SEMINAR04_CVC
rootViewController = MyCollectionViewController()
```

#### 7. App/Project.swift
```swift
dependencies: [
    .project(target: "Seminar04", path: "../Seminar04")
],
schemes: [
    createCustomScheme(name: "Seminar04CVC", configurationName: "Seminar04CVC")
]
```

#### 8. Workspace.swift
```swift
projects: ["Seminar04"]
```

#### 9. Generate!
```bash
tuist generate
```

---

## 🎓 Claude 재부팅 후 작업 순서

1. **이 문서 읽기** (`TUIST_WORKFLOW_GUIDE.md`)
2. **사용자 요구사항 확인** (모듈? 스킴? 둘 다?)
3. **체크리스트 따라 작업**
4. **tuist generate로 테스트**
5. **완료 보고**

---

**작성일**: 2025-10-28
**작성자**: th1ngjin
**버전**: 1.0
