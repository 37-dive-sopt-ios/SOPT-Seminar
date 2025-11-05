//
//  UserService.swift
//  Seminar04
//
//  Created by 이명진 on 11/03/25.
//
//  📚 학습 목표: 네트워크 통신 로직을 별도 클래스로 분리하기
//  - ViewController는 UI만 담당
//  - Service는 네트워크만 담당 (단일 책임 원칙)
//  - 라우터별로 Service 클래스 분리 (/user 담당)

import Foundation

/// 네트워크 에러 (간단한 버전)
/// Network_Basic 전용 에러 타입 (Network 폴더의 NetworkError와 구분)
enum BasicNetworkError: Error {
    case message(String)
}

/// User 관련 API를 담당하는 서비스 클래스
/// 라우터: /user (회원가입, 로그인, 조회, 수정, 삭제)
final class UserService {

    // MARK: - Properties

    /// 서버 기본 URL
    private let baseURL = "http://15.164.129.239"

    // MARK: - 1. 회원가입 API (POST /api/v1/users)

    /// 회원가입 요청
    /// - Parameters:
    ///   - username: 사용자 아이디
    ///   - password: 비밀번호
    ///   - name: 이름
    ///   - email: 이메일
    ///   - age: 나이
    ///   - completion: 성공 시 사용자 ID 반환, 실패 시 에러 메시지 반환
    func register(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        completion: @escaping (Result<Int, BasicNetworkError>) -> Void
    ) {
        // STEP 1: URL 생성
        let urlString = baseURL + "/api/v1/users"
        guard let url = URL(string: urlString) else {
            completion(.failure(.message("잘못된 URL입니다.")))
            return
        }

        // STEP 2: URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // STEP 3: Request Body 생성 (JSON)
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "name": name,
            "email": email,
            "age": age
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(.message("Request Body 생성 실패")))
            return
        }

        print("📤 [회원가입] 요청 시작")
        print("URL: \(urlString)")
        print("Body: \(parameters)")

        // STEP 4: URLSession으로 요청 보내기
        URLSession.shared.dataTask(with: request) { data, response, error in
            // STEP 5: 에러 체크
            if let error = error {
                print("❌ [회원가입] 네트워크 에러: \(error.localizedDescription)")
                completion(.failure(.message("네트워크 에러: \(error.localizedDescription)")))
                return
            }

            // STEP 6: 응답 데이터 확인
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                print("❌ [회원가입] 응답 데이터 없음")
                completion(.failure(.message("응답 데이터가 없습니다.")))
                return
            }

            print("📥 [회원가입] 응답 상태 코드: \(httpResponse.statusCode)")

            // STEP 7: JSON 파싱
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("📥 [회원가입] 응답 데이터: \(json ?? [:])")

                // STEP 8: 성공 여부 확인
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    if let responseData = json?["data"] as? [String: Any],
                       let userId = responseData["id"] as? Int {
                        print("✅ [회원가입] 성공! User ID: \(userId)")
                        completion(.success(userId))
                    } else {
                        completion(.failure(.message("사용자 ID를 찾을 수 없습니다.")))
                    }
                } else {
                    // 서버 에러 메시지 추출
                    let errorMessage = json?["message"] as? String ?? "알 수 없는 오류"
                    print("❌ [회원가입] 실패: \(errorMessage)")
                    completion(.failure(.message(errorMessage)))
                }
            } catch {
                print("❌ [회원가입] JSON 파싱 실패: \(error)")
                completion(.failure(.message("응답 파싱 실패")))
            }
        }.resume()  // ⚠️ 중요! resume() 호출해야 요청이 시작됨
    }

    // MARK: - 2. 로그인 API (POST /api/v1/auth/login)

    /// 로그인 요청
    /// - Parameters:
    ///   - username: 사용자 아이디
    ///   - password: 비밀번호
    ///   - completion: 성공 시 사용자 ID 반환, 실패 시 에러 메시지 반환
    func login(
        username: String,
        password: String,
        completion: @escaping (Result<Int, BasicNetworkError>) -> Void
    ) {
        // STEP 1: URL 생성
        let urlString = baseURL + "/api/v1/auth/login"
        guard let url = URL(string: urlString) else {
            completion(.failure(.message("잘못된 URL입니다.")))
            return
        }

        // STEP 2: URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // STEP 3: Request Body 생성
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(.message("Request Body 생성 실패")))
            return
        }

        print("📤 [로그인] 요청 시작")
        print("URL: \(urlString)")
        print("Body: \(parameters)")

        // STEP 4: URLSession으로 요청 보내기
        URLSession.shared.dataTask(with: request) { data, response, error in
            // STEP 5: 에러 체크
            if let error = error {
                print("❌ [로그인] 네트워크 에러: \(error.localizedDescription)")
                completion(.failure(.message("네트워크 에러: \(error.localizedDescription)")))
                return
            }

            // STEP 6: 응답 데이터 확인
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                print("❌ [로그인] 응답 데이터 없음")
                completion(.failure(.message("응답 데이터가 없습니다.")))
                return
            }

            print("📥 [로그인] 응답 상태 코드: \(httpResponse.statusCode)")

            // STEP 7: JSON 파싱
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("📥 [로그인] 응답 데이터: \(json ?? [:])")

                // STEP 8: 성공 여부 확인
                if httpResponse.statusCode == 200 {
                    if let responseData = json?["data"] as? [String: Any],
                       let userId = responseData["userId"] as? Int {
                        print("✅ [로그인] 성공! User ID: \(userId)")
                        completion(.success(userId))
                    } else {
                        completion(.failure(.message("사용자 ID를 찾을 수 없습니다.")))
                    }
                } else {
                    let errorMessage = json?["message"] as? String ?? "알 수 없는 오류"
                    print("❌ [로그인] 실패: \(errorMessage)")
                    completion(.failure(.message(errorMessage)))
                }
            } catch {
                print("❌ [로그인] JSON 파싱 실패: \(error)")
                completion(.failure(.message("응답 파싱 실패")))
            }
        }.resume()
    }

    // MARK: - 3. 유저 조회 API (GET /api/v1/users/{id})

    /// 유저 정보 조회
    /// - Parameters:
    ///   - id: 조회할 사용자 ID
    ///   - completion: 성공 시 사용자 정보 Dictionary 반환, 실패 시 에러 메시지 반환
    func getUser(id: Int, completion: @escaping (Result<[String: Any], BasicNetworkError>) -> Void) {
        // STEP 1: URL 생성 (GET은 Path에 ID 포함)
        let urlString = baseURL + "/api/v1/users/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.message("잘못된 URL입니다.")))
            return
        }

        // STEP 2: URLRequest 생성 (GET은 Body 없음!)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        print("📤 [유저 조회] 요청 시작")
        print("URL: \(urlString)")

        // STEP 3: URLSession으로 요청 보내기
        URLSession.shared.dataTask(with: request) { data, response, error in
            // STEP 4: 에러 체크
            if let error = error {
                print("❌ [유저 조회] 네트워크 에러: \(error.localizedDescription)")
                completion(.failure(.message("네트워크 에러: \(error.localizedDescription)")))
                return
            }

            // STEP 5: 응답 데이터 확인
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                print("❌ [유저 조회] 응답 데이터 없음")
                completion(.failure(.message("응답 데이터가 없습니다.")))
                return
            }

            print("📥 [유저 조회] 응답 상태 코드: \(httpResponse.statusCode)")

            // STEP 6: JSON 파싱
            do {
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("📥 [유저 조회] 응답 데이터: \(json ?? [:])")

                // STEP 7: 성공 여부 확인
                if httpResponse.statusCode == 200 {
                    if let userData = json?["data"] as? [String: Any] {
                        print("✅ [유저 조회] 성공!")
                        completion(.success(userData))
                    } else {
                        completion(.failure(.message("사용자 데이터를 찾을 수 없습니다.")))
                    }
                } else {
                    let errorMessage = json?["message"] as? String ?? "알 수 없는 오류"
                    print("❌ [유저 조회] 실패: \(errorMessage)")
                    completion(.failure(.message(errorMessage)))
                }
            } catch {
                print("❌ [유저 조회] JSON 파싱 실패: \(error)")
                completion(.failure(.message("응답 파싱 실패")))
            }
        }.resume()
    }
}
