# 🔄 Network_Basic vs Network 비교

> 같은 기능을 두 가지 방식으로 구현했을 때의 차이점을 이해하세요.

---

## 📊 비교표

| 항목 | Network_Basic | Network (고급) |
|------|--------------|---------------|
| **난이도** | ⭐️ 쉬움 | ⭐️⭐️⭐️ 어려움 |
| **코드 길이** | 짧음 (한 파일에 모두) | 길음 (여러 파일로 분산) |
| **재사용성** | ❌ 낮음 (복붙 필요) | ✅ 높음 (추상화됨) |
| **유지보수** | ❌ 어려움 (중복 많음) | ✅ 쉬움 (한 곳만 수정) |
| **학습 목적** | 기본 원리 이해 | 실무 패턴 학습 |
| **실무 사용** | ❌ 권장 안 함 | ✅ 권장 |

---

## 🔍 코드 비교

### 1. 로그인 API 호출

#### Network_Basic 방식 (직접 구현)

```swift
// ❌ 매번 이렇게 긴 코드를 작성해야 함
private func performLogin(username: String, password: String) async {
    // 1. URL 만들기
    let urlString = "http://15.164.129.239/api/v1/auth/login"
    guard let url = URL(string: urlString) else { return }

    // 2. URLRequest 만들기
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // 3. Body 만들기
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    // 4. 요청 보내기
    let (data, response) = try await URLSession.shared.data(for: request)

    // 5. 응답 파싱
    guard let httpResponse = response as? HTTPURLResponse else { return }
    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]

    // 6. 데이터 추출
    if let userData = json?["data"] as? [String: Any],
       let id = userData["id"] as? Int {
        print("로그인 성공: \(id)")
    }
}
```

#### Network 방식 (추상화)

```swift
// ✅ 단 한 줄로 끝!
let response = try await UserAPI.performLogin(username: username, password: password)
```

**내부 동작은 같지만, 복잡한 부분이 숨겨져 있음!**

---

## 🎯 각각 언제 사용하나요?

### Network_Basic 사용 시기

✅ **처음 네트워크를 배울 때**
- URLSession이 어떻게 동작하는지 이해
- HTTP 메서드, 헤더, Body의 개념 학습
- JSON 파싱 직접 경험

✅ **간단한 프로토타입 만들 때**
- API 1~2개만 빠르게 테스트
- 복잡한 구조 필요 없을 때

❌ **실무 프로젝트에서는 사용하지 마세요!**
- 코드 중복이 많음
- 유지보수 어려움
- 에러 처리 불충분

---

### Network (고급) 사용 시기

✅ **실무 프로젝트**
- API가 많을 때 (10개 이상)
- 팀 협업이 필요할 때
- 유지보수가 중요할 때

✅ **이력서/포트폴리오**
- 클린 아키텍처 이해도 어필
- Moya 같은 라이브러리와 유사한 구조

❌ **네트워크 기초를 모를 때**
- 추상화가 많아서 내부 동작 이해 어려움
- Basic부터 먼저 학습 필요

---

## 🚀 학습 로드맵

```
1단계: Network_Basic (현재)
   ↓
   - URLSession 직접 사용
   - JSON 직접 파싱
   - 네트워크 7단계 이해

2단계: Network (고급)
   ↓
   - TargetType 프로토콜 이해
   - 제네릭 활용법 학습
   - 에러 핸들링 체계화

3단계: 실무 라이브러리
   ↓
   - Moya 사용법
   - Alamofire 학습
   - Combine/RxSwift 연동
```

---

## 💡 핵심 차이점

### 코드 재사용성

**Network_Basic:**
```swift
// 회원가입 API
func performRegister(...) { /* 50줄 */ }

// 로그인 API
func performLogin(...) { /* 50줄 */ }

// 유저 조회 API
func performGetUser(...) { /* 40줄 */ }

// 총 140줄 - 중복이 많음!
```

**Network (고급):**
```swift
// 공통 로직 한 번만 구현 (NetworkProvider)
public func request<T>(_ target: TargetType) async throws -> T { /* 50줄 */ }

// 각 API는 명세만 정의
case login(LoginRequest)  // 1줄
case register(RegisterRequest)  // 1줄
case getUser(id: Int)  // 1줄

// 총 50줄 + 3줄 = 53줄 (1/3로 줄어듦!)
```

---

## 🎓 실습 제안

### Step 1: Network_Basic 완전히 이해하기
1. `performLogin` 함수의 모든 줄 이해
2. 콘솔 로그 보면서 요청/응답 확인
3. 직접 다른 API도 추가해보기

### Step 2: Network와 비교하기
1. Network 폴더의 같은 기능 찾기
2. 어떻게 추상화되었는지 비교
3. TargetType의 역할 이해

### Step 3: 스스로 선택하기
- 간단한 프로젝트: Network_Basic 사용
- 실무/포트폴리오: Network 사용

---

## ❓ FAQ

**Q: 둘 중 어느 것을 먼저 배워야 하나요?**
A: 무조건 **Network_Basic**부터! 기본을 모르면 고급 버전을 이해할 수 없습니다.

**Q: 실무에서는 어느 것을 사용하나요?**
A: **Network (고급)** 또는 Moya 같은 라이브러리를 사용합니다.

**Q: Basic만 알아도 취업 가능한가요?**
A: ❌ 기본만 알면 부족합니다. 고급 패턴까지 이해해야 실무 대응 가능합니다.

**Q: 두 코드의 성능 차이가 있나요?**
A: ❌ 성능은 거의 같습니다. 차이는 **코드 품질**과 **유지보수성**입니다.

---

## 🎯 이 둘을 모두 배우는 이유

1. **Basic**: 네트워크 **원리** 이해
2. **고급**: 실무 **패턴** 이해

**둘 다 중요합니다!**
- 원리를 모르면 디버깅 못 함
- 패턴을 모르면 협업 못 함

---

**📚 다음 학습:** Network 폴더의 고급 버전을 차근차근 학습하세요!
