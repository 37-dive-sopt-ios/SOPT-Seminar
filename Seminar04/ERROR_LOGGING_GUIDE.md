# 에러 로깅 가이드

> Seminar04 네트워크 레이어의 상세한 에러 로깅 시스템 설명

## 📊 로그 종류

### 1. 요청 로그 (Request Log)
```
🌐 ========== Network Request ==========
📍 URL: http://15.164.129.239/api/v1/users
🔧 Method: POST
📋 Headers:
   - Content-Type: application/json
📦 Body: {"username":"mj","password":"1234","name":"이명진","email":"test@naver.com","age":29}
=======================================
```

**포함 정보**:
- 요청 URL (baseURL + path)
- HTTP 메서드 (GET, POST, PATCH, DELETE)
- 헤더 정보
- 요청 바디 (JSON)

---

### 2. 응답 로그 (Response Log)

#### ✅ 성공 응답 (2xx)
```
📡 ========== Network Response ==========
✅ Status Code: 200
📋 Headers:
   - Content-Type: application/json
   - Content-Length: 156
📦 Response Body: {"success":true,"code":"OK","message":"success","data":{...}}
========================================

✅ ========== Success ==========
🎉 Request completed successfully!
================================
```

#### ⚠️ 에러 응답 (4xx, 5xx)
```
📡 ========== Network Response ==========
⚠️ Status Code: 409
📋 Headers:
   - Content-Type: application/json
📦 Response Body: {"success":false,"code":"CONFLICT","message":"이미 존재하는 사용자명"}
========================================
```

---

### 3. 에러 로그 (Error Log)

#### 서버 에러 (4xx, 5xx)
```
❌ ========== Network Error ==========
🚨 Error Type: serverError(statusCode: 409, message: Optional("이미 존재하는 사용자명"))
💬 Description: 리소스 충돌이 발생했습니다.
(409: 이미 존재하는 사용자명)
📊 Status Code: 409
💬 Server Message: 이미 존재하는 사용자명
📦 Response Body: {"success":false,"code":"CONFLICT","message":"이미 존재하는 사용자명"}
=====================================

🚨 [Register Error] [NetworkError.serverError] Status: 409, Message: Optional("이미 존재하는 사용자명")
```

**포함 정보**:
- HTTP 상태 코드
- 서버 메시지
- 응답 바디 전체

#### 디코딩 에러
```
❌ Decoding Error Details:
  - Error: keyNotFound(...)
  - Expected Type: UserResponse
  - Response JSON: {"success":true,...}
🔍 Decoding Error Details:
  - Key Not Found: id
  - Coding Path:
  - Description: No value associated with key CodingKeys(stringValue: "id", intValue: nil) ("id").

🚨 [Register Error] [NetworkError.decodingFailed] JSON 디코딩 실패. Response 모델과 실제 응답 구조가 일치하는지 확인하세요.
```

**포함 정보**:
- 디코딩 에러 타입 (typeMismatch, keyNotFound, valueNotFound, dataCorrupted)
- 기대한 타입
- 실제 JSON 응답
- Coding Path (어디서 에러가 났는지)

#### 네트워크 에러 (URLError)
```
❌ ========== Network Error ==========
🚨 Error Type: unknown(Error Domain=NSURLErrorDomain Code=-1009 "인터넷 연결이 끊어진 것 같습니다.")
💬 Description: 인터넷 연결이 끊어졌습니다.
네트워크 연결을 확인해주세요.
🔍 Underlying Error: Error Domain=NSURLErrorDomain Code=-1009 ...
🌐 URLError Code: -1009
🌐 URLError Description: The Internet connection appears to be offline.
=====================================
```

**포함 정보**:
- URLError 코드 (-1009: notConnectedToInternet 등)
- 에러 설명

---

## 🎯 에러 타입별 처리

### NetworkError 케이스

#### 1. `invalidURL`
```swift
// 로그
🚨 Error Type: invalidURL
💬 Description: 잘못된 URL입니다.

// 사용자 메시지
"잘못된 URL입니다."

// 개발자용 상세 정보
"[NetworkError.invalidURL] 요청 URL을 생성할 수 없습니다. baseURL과 path를 확인하세요."
```

#### 2. `invalidResponse`
```swift
// 로그
🚨 Error Type: invalidResponse

// 사용자 메시지
"올바르지 않은 응답입니다."

// 개발자용
"[NetworkError.invalidResponse] 서버 응답을 HTTPURLResponse로 변환할 수 없습니다."
```

#### 3. `decodingFailed`
```swift
// 로그 (상세!)
❌ Decoding Error Details:
  - Type Mismatch: Expected String
  - Coding Path: data → username
  - Description: Expected to decode String but found a number instead.

// 사용자 메시지
"데이터 디코딩에 실패했습니다.
서버 응답 형식을 확인해주세요."

// 개발자용
"[NetworkError.decodingFailed] JSON 디코딩 실패. Response 모델과 실제 응답 구조가 일치하는지 확인하세요."
```

#### 4. `serverError(statusCode:message:)`
```swift
// HTTP 상태 코드별 메시지
case 400: "잘못된 요청입니다."
case 401: "인증에 실패했습니다."
case 403: "접근 권한이 없습니다."
case 404: "요청한 리소스를 찾을 수 없습니다."
case 409: "리소스 충돌이 발생했습니다."
case 500~599: "서버 오류가 발생했습니다."

// 사용자 메시지 예시
"리소스 충돌이 발생했습니다.
(409: 이미 존재하는 사용자명)"
```

#### 5. `unknown(Error)` - URLError 포함
```swift
// URLError 코드별 메시지
case .notConnectedToInternet:
    "인터넷 연결이 끊어졌습니다.
    네트워크 연결을 확인해주세요."

case .timedOut:
    "요청 시간이 초과되었습니다.
    잠시 후 다시 시도해주세요."

case .cannotConnectToHost:
    "서버에 연결할 수 없습니다.
    서버 주소를 확인해주세요."

case .dnsLookupFailed:
    "DNS 조회에 실패했습니다."

case .cancelled:
    "요청이 취소되었습니다."
```

---

## 🔧 BaseResponse 디코딩

서버 응답이 다음과 같은 형식일 때:
```json
{
  "success": true,
  "code": "OK",
  "message": "success",
  "data": {
    "id": 4,
    "username": "mj",
    "name": "이명진",
    "email": "test@naver.com",
    "age": 29,
    "status": "ACTIVE"
  }
}
```

### ❌ 잘못된 방법
```swift
// 직접 UserResponse 디코딩 시도 → 에러!
let user: UserResponse = try await service.request(api)
// ❌ keyNotFound 에러 발생 (id 키를 찾을 수 없음)
```

### ✅ 올바른 방법
```swift
// 1. BaseResponse로 감싼 타입으로 디코딩
let response: BaseResponse<UserResponse> = try await service.request(api)

// 2. data 추출
guard let data = response.data else {
    throw NetworkError.noData
}

// 3. 실제 데이터 사용
return data  // UserResponse
```

### 실제 구현 (UserAPI.swift)
```swift
public static func performRegister(...) async throws -> UserResponse {
    let request = RegisterRequest(...)

    // BaseResponse로 감싸진 응답 디코딩
    let response: BaseResponse<UserResponse> = try await service.request(
        UserAPI.register(request)
    )

    // data가 없으면 에러
    guard let data = response.data else {
        throw NetworkError.noData
    }

    return data
}
```

---

## 🐛 디버깅 팁

### 1. 디코딩 에러 해결하기

#### Coding Path 읽는 법
```
Coding Path: data → user → profile → username
```
→ `response.data.user.profile.username`에서 에러 발생

#### 에러 타입별 해결 방법

**keyNotFound**:
- JSON에 해당 키가 없음
- 서버 응답 확인: 키 이름 오타? Optional로 선언?

**typeMismatch**:
- 타입이 맞지 않음 (String 기대했는데 Int가 옴)
- 모델의 프로퍼티 타입 확인

**valueNotFound**:
- 값이 null인데 Optional이 아님
- 모델에서 Optional(`?`) 추가

**dataCorrupted**:
- JSON 형식 자체가 잘못됨
- 서버 응답 로그 확인

### 2. 로그 보는 순서

1. **요청 로그** 확인
   - URL이 올바른가?
   - Body가 제대로 인코딩되었나?

2. **응답 로그** 확인
   - 상태 코드는?
   - 응답 Body 구조는?

3. **에러 로그** 분석
   - 어떤 타입의 에러?
   - Coding Path는 어디?
   - 기대한 타입 vs 실제 타입

### 3. 자주 발생하는 문제

#### 문제 1: BaseResponse 감싸기 잊음
```swift
// ❌
let user: UserResponse = try await service.request(api)

// ✅
let response: BaseResponse<UserResponse> = try await service.request(api)
guard let user = response.data else { throw NetworkError.noData }
```

#### 문제 2: Optional 처리 누락
```swift
// 서버 응답: {"email": null}

// ❌
struct UserResponse: Decodable {
    let email: String  // 에러!
}

// ✅
struct UserResponse: Decodable {
    let email: String?  // Optional로 처리
}
```

#### 문제 3: 타입 불일치
```swift
// 서버 응답: {"age": "29"}  (문자열!)

// ❌
struct UserResponse: Decodable {
    let age: Int  // 에러!
}

// ✅
struct UserResponse: Decodable {
    let age: String  // 서버에 맞춤
    // 또는 커스텀 디코딩으로 변환
}
```

---

## 📝 로그 활용 예시

### 실제 디버깅 과정

1. **사용자가 회원가입 버튼 클릭**

2. **콘솔 로그 확인**
```
🌐 ========== Network Request ==========
📍 URL: http://15.164.129.239/api/v1/users
🔧 Method: POST
📦 Body: {"username":"mj","password":"1234",...}
=======================================

📡 ========== Network Response ==========
⚠️ Status Code: 409
📦 Response Body: {"success":false,"message":"이미 존재하는 사용자명"}
========================================

❌ ========== Network Error ==========
🚨 Error Type: serverError(statusCode: 409, ...)
📊 Status Code: 409
💬 Server Message: 이미 존재하는 사용자명
=====================================
```

3. **문제 파악**
   - 409 Conflict → 중복된 username
   - 서버 메시지: "이미 존재하는 사용자명"

4. **해결**
   - 다른 username으로 재시도
   - UI에 중복 체크 기능 추가 고려

---

## 🎯 요약

### 로그로 알 수 있는 것
✅ 요청이 제대로 전송되었는가?
✅ 서버가 어떤 응답을 보냈는가?
✅ 디코딩이 왜 실패했는가?
✅ 네트워크 연결 상태는?

### 로그를 보고 해야 할 일
1. **요청 로그** → URL, Body 검증
2. **응답 로그** → 상태 코드, 응답 구조 확인
3. **에러 로그** → 에러 타입별 해결 방법 적용

### 개발 시 주의사항
⚠️ BaseResponse 래핑 잊지 말기
⚠️ Optional 처리 확인
⚠️ 타입 일치 확인
⚠️ Coding Path로 에러 위치 파악

---

**마지막 업데이트**: 2025-10-30
