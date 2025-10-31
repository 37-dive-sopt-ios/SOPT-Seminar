# Seminar04 - Swift Concurrency & URLSession 네트워크 레이어

> URLSession과 Swift Concurrency(async/await)를 사용한 네트워크 추상화 레이어 예제

## 📚 학습 목표

1. **POP(Protocol Oriented Programming)** 적용
2. **Swift Concurrency** (async/await) 활용
3. **URLSession** 기반 네트워크 레이어 구축
4. Moya/Alamofire 없이 **First-Party 솔루션**으로 추상화
5. **5개의 REST API** 실습

---

## 🏗️ 아키텍처 구조

```
Seminar04/
├── Network/
│   ├── Base/
│   │   ├── HTTPMethod.swift          # HTTP 메서드 정의
│   │   ├── NetworkError.swift        # 에러 타입 정의
│   │   ├── TargetType.swift          # 요청 프로토콜 (Moya의 TargetType!)
│   │   ├── Responsable.swift         # 응답 프로토콜
│   │   └── NetworkService.swift      # 네트워크 Provider 구현체
│   ├── API/
│   │   └── UserAPI.swift             # User 관련 5개 API
│   ├── DTO/
│   │   └── UserDTO.swift             # Request/Response 모델
│   ├── LoginViewController_Network.swift
│   └── WelcomeViewController_Network.swift
```

---

## 🎯 핵심 개념

### 1. POP (Protocol Oriented Programming)

#### `TargetType` 프로토콜 (Moya와 동일!)
```swift
protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }        // ⭐️ Moya의 핵심!
    var headers: [String: String]? { get }
}

// HTTPTask enum - Moya의 Task와 동일한 개념
enum HTTPTask {
    case requestPlain                           // 바디 없음
    case requestJSONEncodable(Encodable)        // JSON 바디
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
```

- **왜 프로토콜?** Moya의 `TargetType`과 동일한 패턴으로, 각 API를 선언적으로 정의할 수 있음
- **Task 기반**: Moya처럼 `task` 속성으로 요청 타입 정의 (Plain, JSON, Parameters)
- **Default Implementation**: `toURLRequest()` 메서드로 URLRequest 자동 생성
- **유연성**: enum으로 여러 API를 하나의 타입으로 관리 가능

#### `NetworkProviding` 프로토콜 (Moya의 ProviderType!)
```swift
protocol NetworkProviding {
    func request<T: Decodable>(_ target: TargetType) async throws -> T
}
```

- **의존성 주입**: 테스트 시 Mock Provider로 교체 가능
- **제네릭**: 어떤 Decodable 타입이든 반환 가능
- **Moya와 동일한 네이밍**: Provider 패턴 적용

---

### 2. Swift Concurrency (async/await)

#### Before: Completion Handler 방식
```swift
// ❌ 복잡하고 에러 처리가 어려움
func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
    // URLSession 코드...
}
```

#### After: async/await 방식
```swift
// ✅ 간결하고 직관적
func login(username: String, password: String) async throws -> LoginResponse {
    return try await provider.request(UserAPI.login(request))
}
```

#### 사용 예시
```swift
Task {
    do {
        let response = try await UserAPI.performLogin(
            username: "johndoe",
            password: "P@ssw0rd!"
        )
        print("로그인 성공: \(response.message)")
    } catch {
        print("로그인 실패: \(error)")
    }
}
```

---

### 3. UserAPI - 5개 API 구현

#### Enum으로 API 정의 (Moya 스타일!)
```swift
enum UserAPI {
    case register(RegisterRequest)           // POST /api/v1/users
    case login(LoginRequest)                 // POST /api/v1/auth/login
    case getUser(id: Int)                    // GET /api/v1/users/{id}
    case updateUser(id: Int, UpdateUserRequest)  // PATCH /api/v1/users/{id}
    case deleteUser(id: Int)                 // DELETE /api/v1/users/{id}
}
```

#### TargetType 구현
```swift
extension UserAPI: TargetType {
    var baseURL: String {
        return "https://api.example.com"
    }

    var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let id):
            return "/api/v1/users/\(id)"
        // ...
        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login: return .post
        case .getUser: return .get
        case .updateUser: return .patch
        case .deleteUser: return .delete
        }
    }

    // ⭐️ Moya의 핵심: Task로 요청 타입 정의
    var task: HTTPTask {
        switch self {
        case .register(let request):
            return .requestJSONEncodable(request)  // JSON 바디
        case .login(let request):
            return .requestJSONEncodable(request)  // JSON 바디
        case .getUser:
            return .requestPlain                   // 바디 없음
        case .updateUser(_, let request):
            return .requestJSONEncodable(request)  // JSON 바디
        case .deleteUser:
            return .requestPlain                   // 바디 없음
        }
    }
}
```

**Moya와의 차이점:**
- Moya: `case requestJSONEncodable(_ encodable: Encodable)`
- 우리 구현: `case requestJSONEncodable(Encodable)` - 완전히 동일!

---

## 🚀 사용법

### 1. 회원가입 API
```swift
Task {
    let response = try await UserAPI.performRegister(
        username: "johndoe",
        password: "P@ssw0rd!",
        name: "홍길동",
        email: "hong@example.com",
        age: 25
    )
    print("회원가입 성공: \(response.name)")
}
```

### 2. 로그인 API
```swift
Task {
    let response = try await UserAPI.performLogin(
        username: "johndoe",
        password: "P@ssw0rd!"
    )
    print("로그인 성공: User ID \(response.userId)")
}
```

### 3. 개인정보 조회 API
```swift
Task {
    let user = try await UserAPI.performGetUser(id: 1)
    print("이름: \(user.name), 이메일: \(user.email)")
}
```

### 4. 개인정보 수정 API
```swift
Task {
    let updatedUser = try await UserAPI.performUpdateUser(
        id: 1,
        name: "김철수",
        email: "kim@example.com",
        age: 30
    )
    print("수정 완료: \(updatedUser.name)")
}
```

### 5. 회원탈퇴 API
```swift
Task {
    let response = try await UserAPI.performDeleteUser(id: 1)
    print("탈퇴 완료: \(response.message)")
}
```

---

## 🎨 UI 화면 구성

### LoginViewController_Network
- **회원가입** 버튼: 5개 필드 입력 후 POST /api/v1/users
- **로그인** 버튼: username, password 입력 후 POST /api/v1/auth/login
- 성공 시 WelcomeViewController로 이동

### WelcomeViewController_Network
- **개인정보 조회**: GET /api/v1/users/{id} - 사용자 정보 표시
- **개인정보 수정**: PATCH /api/v1/users/{id} - 이름/이메일/나이 수정
- **회원탈퇴**: DELETE /api/v1/users/{id} - 탈퇴 후 로그인 화면으로 복귀

---

## 🔍 핵심 구현 포인트

### 1. NetworkProvider - URLSession 래퍼 (Moya의 MoyaProvider!)
```swift
final class NetworkProvider: NetworkProviding {
    func request<T: Decodable>(_ target: TargetType) async throws -> T {
        // 1. URLRequest 생성
        let urlRequest = try target.toURLRequest()

        // 2. URLSession으로 요청 (async/await!)
        let (data, response) = try await session.data(for: urlRequest)

        // 3. 응답 검증
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        // 4. 상태 코드 체크
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        // 5. 데이터 디코딩
        return try JSONDecoder().decode(T.self, from: data)
    }
}
```

### 2. TargetType의 toURLRequest()
```swift
extension TargetType {
    func toURLRequest() throws -> URLRequest {
        // URL 생성
        guard var urlComponents = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }

        // 쿼리 파라미터 추가
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue

        // 헤더 추가
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        // 바디 추가 (Encodable)
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        return request
    }
}
```

---

## 📝 학습 포인트

### 1. **왜 POP를 사용하는가?**
- ✅ **재사용성**: TargetType을 준수하면 모든 API가 같은 방식으로 동작
- ✅ **테스트 용이**: Protocol을 통해 Mock 객체 주입 가능 (NetworkProviding)
- ✅ **확장성**: 새로운 API 추가가 간단 (enum에 case만 추가)

### 2. **Moya와의 비교**
- ✅ **동일한 네이밍**: TargetType, Provider 패턴 그대로 적용
- ✅ **First-Party**: URLSession만 사용, 외부 의존성 없음
- ✅ **학습 곡선**: 기본 개념부터 이해 가능
- ⚠️ **기능 차이**: Plugin, Interceptor 등은 직접 구현 필요
- 💡 **실무 적용**: Moya 사용 시 개념을 완벽히 이해하고 사용 가능

### 3. **async/await의 장점**
- ✅ **가독성**: Completion Handler 지옥 탈출
- ✅ **에러 처리**: try-catch로 통일된 에러 처리
- ✅ **순차 실행**: 비동기 코드를 동기 코드처럼 작성

### 4. **실무에서는?**
- 실제 프로젝트에서는 Moya나 Alamofire 많이 사용
- 하지만 **원리를 이해**하면 어떤 라이브러리든 쉽게 사용 가능
- **면접 질문**: "URLSession으로 네트워크 추상화 어떻게 하나요?" 대응 가능!

---

## ⚙️ 실행 방법

1. Xcode에서 **Seminar04** 스킴 선택
2. Cmd + R 실행
3. LoginViewController_Network에서 회원가입/로그인 테스트
4. WelcomeViewController_Network에서 조회/수정/삭제 테스트

---

## 🐛 주의사항

⚠️ **실제 API 서버 URL 설정 필요!**

현재 `UserAPI.swift`의 `baseURL`은 예시 URL입니다:
```swift
var baseURL: String {
    return "https://api.example.com"  // TODO: 실제 서버 URL로 변경!
}
```

실제 서버 주소로 변경 후 테스트하세요!

---

## 📚 참고 자료

- [Swift Concurrency 공식 문서](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [URLSession 공식 문서](https://developer.apple.com/documentation/foundation/urlsession)
- [Protocol Oriented Programming (WWDC)](https://developer.apple.com/videos/play/wwdc2015/408/)
- [Moya](https://github.com/Moya/Moya) - 참고용 네트워크 추상화 라이브러리

---

**만든이**: Claude AI 🤖
**날짜**: 2025-10-30
