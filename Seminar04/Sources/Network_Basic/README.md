# 📚 Network_Basic - 네트워크 기초 학습

> URLSession을 직접 사용하여 네트워크 통신의 기본 원리를 학습합니다.
> Service 클래스로 책임을 분리하여 깔끔한 코드 작성법을 배웁니다.

## 🎯 학습 목표

1. **URLSession의 기본 사용법** 이해하기
2. **HTTP 메서드** (GET, POST) 이해하기
3. **JSON 직렬화/역직렬화** 직접 구현하기
4. **책임 분리** (ViewController vs Service)
5. **completion handler** 패턴 이해하기

---

## 📁 파일 구조

```
Network_Basic/
├── BasicNetworkViewController.swift  # UI 담당 (View)
├── UserService.swift                 # 네트워크 담당 (Model)
└── README.md                         # 학습 가이드
```

### 왜 파일을 나눴나요?

**❌ 나쁜 예 (모든 코드를 ViewController에)**
```swift
class ViewController {
    // UI 코드 (200줄)
    // + 네트워크 코드 (300줄)
    // = 총 500줄! 너무 길고 복잡함
}
```

**✅ 좋은 예 (책임 분리)**
```swift
// BasicNetworkViewController.swift (UI만)
class BasicNetworkViewController {
    // UI 코드만 (200줄)
    // UserService 호출만!
}

// UserService.swift (네트워크만)
class UserService {
    // 네트워크 코드만 (250줄)
    // /user 라우터 전담
}
```

---

## 🔄 전체 흐름

```
[사용자]
   ↓ 버튼 클릭
[BasicNetworkViewController]
   ↓ userService.register() 호출
[UserService]
   ↓ URLSession으로 서버에 요청
[서버] 🌐
   ↓ JSON 응답
[UserService]
   ↓ completion(result) 호출
[BasicNetworkViewController]
   ↓ UI 업데이트 (결과 표시)
[사용자]
```

---

## 📝 UserService 클래스 이해하기

### 라우터란?
- URL의 **분기점**을 의미합니다
- 이 클래스는 `/user` 관련 API만 담당
- 예: `/user/register`, `/user/login`, `/user/123`

### 왜 클래스로 만들었나요?
- 관련된 API들을 **하나로 묶기 위해**
- 다른 라우터가 생기면 새로운 클래스 추가 가능
  - `PostService` → `/post` 관련
  - `CommentService` → `/comment` 관련

---

## 🔍 코드 상세 분석

### 1. UserService의 register 메서드

```swift
func register(
    username: String,
    password: String,
    name: String,
    email: String,
    age: Int,
    completion: @escaping (Result<Int, BasicNetworkError>) -> Void  // ← completion handler!
) {
    // STEP 1: URL 생성
    let urlString = baseURL + "/api/v1/users"
    guard let url = URL(string: urlString) else {
        completion(.failure("잘못된 URL입니다."))  // 실패 시 바로 리턴
        return
    }

    // STEP 2: URLRequest 생성
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // STEP 3: Request Body 생성
    let parameters: [String: Any] = [
        "username": username,
        "password": password,
        "name": name,
        "email": email,
        "age": age
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

    // STEP 4: URLSession으로 요청 (비동기!)
    URLSession.shared.dataTask(with: request) { data, response, error in
        // STEP 5~8: 응답 처리 후 completion 호출
        if 성공 {
            completion(.success(userId))
        } else {
            completion(.failure(errorMessage))
        }
    }.resume()  // ⚠️ 중요!
}
```

---

### 2. BasicNetworkViewController에서 호출

```swift
private func performRegister(...) {
    startLoading()  // 로딩 시작

    // UserService에게 요청
    userService.register(
        username: username,
        password: password,
        name: name,
        email: email,
        age: age
    ) { [weak self] result in  // ← completion closure
        // ⚠️ 여기는 background thread!
        DispatchQueue.main.async {  // UI 업데이트는 main thread로!
            self?.stopLoading()

            switch result {
            case .success(let userId):
                self?.showResult(success: true, message: "성공! ID: \(userId)")
            case .failure(let errorMessage):
                self?.showResult(success: false, message: errorMessage)
            }
        }
    }
}
```

---

## 💡 핵심 개념

### 1. Completion Handler란?

**비동기 작업이 끝난 후 "완료되었어요!" 알려주는 클로저**

```swift
// 함수 정의
func doSomething(completion: @escaping (Result<Data, Error>) -> Void) {
    // 비동기 작업...
    completion(.success(data))  // 끝나면 completion 호출!
}

// 함수 호출
doSomething { result in
    // 여기서 결과 받음!
}
```

**왜 @escaping?**
- 함수가 끝난 **후에** 실행되기 때문
- URLSession은 네트워크 요청이 끝나면 completion 호출

---

### 2. Result 타입이란?

**성공/실패를 타입 안전하게 표현**

```swift
// 정의
enum Result<Success, Failure> {
    case success(Success)
    case failure(Failure)
}

// 사용
let result: Result<Int, String> = .success(123)

switch result {
case .success(let userId):
    print("성공! ID: \(userId)")
case .failure(let error):
    print("실패: \(error)")
}
```

---

### 3. DispatchQueue.main.async란?

**UI 업데이트는 무조건 메인 스레드에서!**

```swift
URLSession.shared.dataTask(...) { data, response, error in
    // ⚠️ 여기는 background thread!

    DispatchQueue.main.async {
        // ✅ 여기는 main thread! UI 업데이트 가능
        self.resultLabel.text = "완료!"
    }
}
```

**왜 필요한가?**
- URLSession completion은 background thread에서 실행
- UIKit은 main thread에서만 작동
- 안 하면 크래시 or UI 업데이트 안 됨

---

### 4. [weak self]란?

**메모리 누수 방지**

```swift
userService.register(...) { [weak self] result in
    //                        ↑ weak로 참조!
    self?.showResult(...)  // self가 nil일 수 있음
}
```

**왜 필요한가?**
- completion이 self를 강하게 참조하면 → 순환 참조 발생
- weak로 참조하면 → ViewController가 사라지면 completion도 해제

---

## 🌐 API 명세

### 1. 회원가입 (POST)
```
POST /api/v1/users

Request Body:
{
  "username": "myid",
  "password": "1234",
  "name": "홍길동",
  "email": "test@test.com",
  "age": 25
}

Response (성공):
{
  "success": true,
  "code": "201",
  "message": "회원가입 성공",
  "data": {
    "id": 123,
    "username": "myid",
    ...
  }
}
```

### 2. 로그인 (POST)
```
POST /api/v1/auth/login

Request Body:
{
  "username": "myid",
  "password": "1234"
}

Response (성공):
{
  "success": true,
  "code": "200",
  "message": "로그인 성공",
  "data": {
    "id": 123,
    ...
  }
}
```

### 3. 유저 조회 (GET)
```
GET /api/v1/users/{id}

Response (성공):
{
  "success": true,
  "code": "200",
  "data": {
    "id": 123,
    "username": "myid",
    "name": "홍길동",
    "email": "test@test.com",
    "age": 25
  }
}
```

---

## 🎓 학습 순서

### 1단계: UserService 이해하기
1. `UserService.swift` 파일 열기
2. `register` 메서드 한 줄씩 읽기
3. STEP 1~8 주석 따라가기
4. completion이 언제 호출되는지 확인

### 2단계: BasicNetworkViewController 이해하기
1. `BasicNetworkViewController.swift` 파일 열기
2. `performRegister` 메서드 읽기
3. userService 호출 → completion 받기 → UI 업데이트 흐름 파악

### 3단계: 직접 실행해보기
1. 앱 실행
2. 회원가입 → 로그인 → 유저 조회 순서로 테스트
3. 콘솔 로그 보면서 흐름 확인

### 4단계: 코드 수정해보기
1. UserService에 유저 수정 API 추가 (PATCH)
2. UserService에 유저 삭제 API 추가 (DELETE)
3. BasicNetworkViewController에서 호출

---

## 💡 GET vs POST 차이

| 구분 | GET | POST |
|------|-----|------|
| **용도** | 데이터 조회 | 데이터 생성/전송 |
| **데이터 위치** | URL Path에 포함 | Request Body에 포함 |
| **Request Body** | ❌ 없음 | ✅ 있음 |
| **보안** | URL에 노출 | Body에 숨겨짐 |
| **예시** | `/users/123` | JSON in Body |

---

## 🚀 다음 단계

이 기본 네트워크 코드가 익숙해지면:

1. **Network 폴더**의 고급 버전 학습
   - async/await 패턴 (completion handler보다 깔끔!)
   - TargetType 프로토콜로 API 추상화
   - 제네릭으로 재사용성 높이기

2. **실무 라이브러리** 학습
   - Alamofire (URLSession 래핑)
   - Moya (네트워크 추상화)

---

## ⚠️ 주의사항

### 1. .resume() 꼭 호출하기!
```swift
URLSession.shared.dataTask(...) { ... }.resume()
//                                       ↑ 이거 안 하면 요청 안 보내짐!
```

### 2. UI는 main thread에서!
```swift
DispatchQueue.main.async {
    self.label.text = "완료"  // ✅
}

self.label.text = "완료"  // ❌ background thread에서 UI 업데이트!
```

### 3. [weak self] 잊지 않기!
```swift
userService.login(...) { [weak self] result in  // ✅
    self?.showResult(...)
}

userService.login(...) { result in  // ❌ 메모리 누수 가능!
    self.showResult(...)
}
```

---

## 📝 체크리스트

학습 완료 후 체크해보세요:

- [ ] URLRequest를 직접 만들 수 있다
- [ ] POST와 GET의 차이를 설명할 수 있다
- [ ] JSON을 Dictionary로 변환할 수 있다
- [ ] completion handler의 동작 원리를 안다
- [ ] Result 타입을 사용할 수 있다
- [ ] DispatchQueue.main.async가 왜 필요한지 안다
- [ ] [weak self]를 언제 써야 하는지 안다
- [ ] ViewController와 Service의 책임을 구분할 수 있다

---

**🎉 모두 체크했다면 Network 폴더의 고급 버전(async/await)으로 넘어가세요!**
