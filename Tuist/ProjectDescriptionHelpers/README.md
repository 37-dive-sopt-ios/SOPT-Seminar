# Tuist 헬퍼 함수 가이드 📚

Tuist 프로젝트에서 빠르게 모듈과 스킴을 추가할 수 있는 헬퍼 함수 모음입니다.

## 📦 모듈 생성

### 1. Framework 모듈 생성

```swift
let project = Project.framework(
    name: "Seminar04",
    dependencies: [
        .project(target: "Core", path: "../Core"),
        .external(name: "SnapKit")
    ]
)
```

### 2. 앱 타겟 생성 (여러 환경 지원)

```swift
let project = Project(
    name: "MyApp",
    targets: [
        // DEV 환경
        .appTarget(
            name: "DEV-MyApp",
            bundleId: "com.th1ngjin.dev",
            configuration: .debug,
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        ),

        // QA 환경
        .appTarget(
            name: "QA-MyApp",
            bundleId: "com.th1ngjin.qa",
            configuration: .configuration("QA"),
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        ),

        // PROD 환경
        .appTarget(
            name: "PROD-MyApp",
            bundleId: "com.th1ngjin",
            configuration: .release,
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        )
    ]
)
```

## 🎯 스킴 생성

### 1. 세미나 스킴 (번호로 자동 생성)

```swift
schemes: [
    createSeminarScheme(number: 1),  // Seminar01
    createSeminarScheme(number: 2),  // Seminar02
    createSeminarScheme(number: 3),  // Seminar03
]
```

### 2. 세미나 클로저 스킴

```swift
schemes: [
    createSeminarClosureScheme(number: 2)  // Seminar02Closure
]
```

### 3. 커스텀 스킴 (자유롭게 생성)

```swift
schemes: [
    createCustomScheme(
        name: "Seminar03CVC",
        configurationName: "Seminar03CVC",
        targetName: "App"
    ),

    createCustomScheme(
        name: "MyCustomScheme",
        configurationName: "Debug",
        targetName: "MyApp"
    )
]
```

### 4. 환경별 스킴 (DEV / QA / PROD)

```swift
schemes: [
    // DEV 환경 스킴
    createEnvironmentScheme(
        environment: "DEV",
        appName: "MyApp"
    ),

    // QA 환경 스킴
    createEnvironmentScheme(
        environment: "QA",
        appName: "MyApp"
    ),

    // PROD 환경 스킴
    createEnvironmentScheme(
        environment: "PROD",
        appName: "MyApp"
    )
]
```

**자동으로 설정되는 것들:**
- DEV/QA는 `debug` configuration 사용
- PROD는 `release` configuration 사용
- 타겟 이름은 `환경-앱이름` 형식 (예: "DEV-MyApp")

**커스텀 설정:**
```swift
createEnvironmentScheme(
    environment: "QA",
    appName: "MyApp",
    targetName: "CustomQA-MyApp",        // 커스텀 타겟 이름
    configuration: .configuration("QA")   // 커스텀 configuration
)
```

## 🚀 실전 예제

### App/Project.swift에서 여러 스킴 한번에 추가

```swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    settings: .settings(configurations: allConfigurations),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.th1ngjin.App",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Core", path: "../Core"),
                .project(target: "Seminar01", path: "../Seminar01"),
            ]
        )
    ],
    schemes: [
        // 기본 세미나 스킴들
        createSeminarScheme(number: 1),
        createSeminarScheme(number: 2),
        createSeminarScheme(number: 3),

        // 클로저 스킴
        createSeminarClosureScheme(number: 2),

        // 커스텀 스킴들
        createCustomScheme(name: "Seminar03MVC", configurationName: "Seminar03MVC"),
        createCustomScheme(name: "Seminar03ChatList", configurationName: "Seminar03ChatList"),
        createCustomScheme(name: "Seminar03CVC", configurationName: "Seminar03CVC"),
    ]
)
```

### 환경별 앱 프로젝트 생성 (GREEN 블로그 스타일)

```swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MyApp",
    targets: [
        // DEV 타겟
        .appTarget(
            name: "DEV-MyApp",
            bundleId: "com.th1ngjin.dev",
            configuration: .debug,
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        ),

        // QA 타겟
        .appTarget(
            name: "QA-MyApp",
            bundleId: "com.th1ngjin.qa",
            configuration: .configuration("QA"),
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        ),

        // PROD 타겟
        .appTarget(
            name: "PROD-MyApp",
            bundleId: "com.th1ngjin",
            configuration: .release,
            dependencies: [
                .project(target: "Core", path: "../Core")
            ]
        )
    ],
    schemes: [
        createEnvironmentScheme(environment: "DEV", appName: "MyApp"),
        createEnvironmentScheme(environment: "QA", appName: "MyApp"),
        createEnvironmentScheme(environment: "PROD", appName: "MyApp")
    ],
    settings: .settings(
        configurations: [
            .debug(name: .debug),
            .debug(name: "QA"),
            .release(name: .release)
        ]
    )
)
```

## 💡 Tips

### 1. Configuration 추가하기
새로운 Configuration을 추가하려면 `Configuration+Seminar.swift`를 수정:

```swift
public enum SeminarConfig: String, CaseIterable {
    case seminar04 = "Seminar04"  // 👈 여기에 추가

    var compilationFlag: String {
        case .seminar04:
            return "SEMINAR04"     // 👈 플래그 추가
    }
}
```

### 2. Package.swift도 업데이트
```swift
baseSettings: .settings(
    configurations: [
        .debug(name: "Seminar04"),  // 👈 여기에 추가
        .debug(name: "Debug"),
        .release(name: "Release")
    ]
)
```

### 3. 빠르게 스킴만 추가하기
기존 App에 스킴만 추가하고 싶다면:

```swift
schemes: [
    createCustomScheme(
        name: "NewFeature",
        configurationName: "Debug"
    )
]
```

## 📝 요약

| 함수 | 용도 | 사용 예시 |
|------|------|-----------|
| `Project.framework()` | Framework 모듈 생성 | `Project.framework(name: "Core")` |
| `Project.appTarget()` | 앱 타겟 생성 (환경별) | DEV/QA/PROD 타겟 생성 |
| `createSeminarScheme()` | 세미나 스킴 자동 생성 | `createSeminarScheme(number: 4)` |
| `createSeminarClosureScheme()` | 클로저 스킴 생성 | `createSeminarClosureScheme(number: 2)` |
| `createCustomScheme()` | 자유 스킴 생성 | 원하는 스킴 커스텀 생성 |
| `createEnvironmentScheme()` | 환경별 스킴 (DEV/QA/PROD) | 배포 환경별 스킴 자동 생성 |

---

**작성자**: th1ngjin
