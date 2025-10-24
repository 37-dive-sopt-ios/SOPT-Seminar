# Claude AI 코딩 가이드

> 이 파일은 Claude AI가 코드를 작성할 때 따라야 할 규칙과 패턴을 정의합니다.

## 📱 UI 코드 작성 규칙

### ✅ 필수 구조

모든 UIView/UIViewController의 UI 초기화는 다음 3단계 구조를 **반드시** 따릅니다:

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

## 📝 요약

**Claude AI는 UI 코드를 작성할 때 반드시:**
1. `setUI()` → `setHierarchy()` → `setLayout()` 구조 사용
2. SnapKit으로 레이아웃 작성
3. Core 모듈의 `addSubviews` 사용
4. 적절한 MARK 주석 추가

**절대 하지 말 것:**
1. `setup~` 메서드명 사용
2. `NSLayoutConstraint.activate` 사용
3. 개별 `addSubview` 호출

---

*마지막 업데이트: 2025-10-24*
