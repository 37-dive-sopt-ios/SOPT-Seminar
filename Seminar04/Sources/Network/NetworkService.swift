//
//  NetworkService.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// 네트워크 서비스 프로토콜 (Moya의 Provider 컨셉!)
public protocol NetworkProviding {
    /// Swift Concurrency를 사용한 네트워크 요청
    func request<T: Decodable>(_ target: TargetType) async throws -> T
}

/// URLSession 기반 NetworkProvider 구현체 (Moya의 MoyaProvider와 유사!)
public final class NetworkProvider: NetworkProviding {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Initialization

    public init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - NetworkProviding

    /// Swift Concurrency를 사용한 네트워크 요청
    /// - Parameter target: TargetType 프로토콜을 준수하는 요청 객체
    /// - Returns: Decodable 타입으로 디코딩된 응답 데이터
    public func request<T: Decodable>(_ target: TargetType) async throws -> T {
        do {
            // 1. URLRequest 생성
            let urlRequest = try target.toURLRequest()

            // 디버깅을 위한 로그
            printRequest(urlRequest)

            // 2. URLSession으로 요청 (async/await 사용!)
            let (data, response) = try await session.data(for: urlRequest)

            // 3. 응답 검증
            guard let httpResponse = response as? HTTPURLResponse else {
                printError(NetworkError.invalidResponse)
                throw NetworkError.invalidResponse
            }

            // 디버깅을 위한 로그
            printResponse(httpResponse, data: data)

            // 4. 상태 코드 체크
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = try? JSONDecoder().decode(
                    BaseResponse<EmptyResponse>.self,
                    from: data
                ).message
                let error = NetworkError.serverError(
                    statusCode: httpResponse.statusCode,
                    message: errorMessage
                )
                printError(error, data: data)
                throw error
            }

            // 5. 데이터 디코딩
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                printSuccess()
                return decodedData
            } catch let decodingError {
                print("❌ Decoding Error Details:")
                print("  - Error: \(decodingError)")
                print("  - Expected Type: \(T.self)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("  - Response JSON: \(jsonString)")
                }
                if let decodingError = decodingError as? DecodingError {
                    printDecodingErrorDetails(decodingError)
                }
                throw NetworkError.decodingFailed
            }
        } catch let error as NetworkError {
            // NetworkError는 그대로 throw
            throw error
        } catch {
            // 그 외 에러 (URLError 등)
            printError(NetworkError.unknown(error))
            throw NetworkError.unknown(error)
        }
    }

    // MARK: - Debug Helpers

    private func printRequest(_ request: URLRequest) {
        print("\n🌐 ========== Network Request ==========")
        print("📍 URL: \(request.url?.absoluteString ?? "nil")")
        print("🔧 Method: \(request.httpMethod ?? "nil")")
        print("📋 Headers:")
        if let headers = request.allHTTPHeaderFields {
            headers.forEach { print("   - \($0.key): \($0.value)") }
        } else {
            print("   - None")
        }
        if let body = request.httpBody,
           let jsonString = String(data: body, encoding: .utf8) {
            print("📦 Body: \(jsonString)")
        }
        print("=======================================\n")
    }

    private func printResponse(_ response: HTTPURLResponse, data: Data) {
        let statusEmoji = (200...299).contains(response.statusCode) ? "✅" : "⚠️"
        print("\n📡 ========== Network Response ==========")
        print("\(statusEmoji) Status Code: \(response.statusCode)")
        print("📋 Headers:")
        response.allHeaderFields.forEach { print("   - \($0.key): \($0.value)") }
        if let jsonString = String(data: data, encoding: .utf8) {
            print("📦 Response Body: \(jsonString)")
        }
        print("========================================\n")
    }

    private func printError(_ error: NetworkError, data: Data? = nil) {
        print("\n❌ ========== Network Error ==========")
        print("🚨 Error Type: \(error)")
        print("💬 Description: \(error.localizedDescription)")

        switch error {
        case .serverError(let statusCode, let message):
            print("📊 Status Code: \(statusCode)")
            if let message = message {
                print("💬 Server Message: \(message)")
            }
            if let data = data, let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Response Body: \(jsonString)")
            }
        case .unknown(let underlyingError):
            print("🔍 Underlying Error: \(underlyingError)")
            if let urlError = underlyingError as? URLError {
                print("🌐 URLError Code: \(urlError.code.rawValue)")
                print("🌐 URLError Description: \(urlError.localizedDescription)")
            }
        default:
            break
        }
        print("=====================================\n")
    }

    private func printDecodingErrorDetails(_ error: DecodingError) {
        print("🔍 Decoding Error Details:")
        switch error {
        case .typeMismatch(let type, let context):
            print("  - Type Mismatch: Expected \(type)")
            print("  - Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            print("  - Description: \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            print("  - Value Not Found: Expected \(type)")
            print("  - Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            print("  - Description: \(context.debugDescription)")
        case .keyNotFound(let key, let context):
            print("  - Key Not Found: \(key.stringValue)")
            print("  - Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            print("  - Description: \(context.debugDescription)")
        case .dataCorrupted(let context):
            print("  - Data Corrupted")
            print("  - Coding Path: \(context.codingPath.map { $0.stringValue }.joined(separator: " → "))")
            print("  - Description: \(context.debugDescription)")
        @unknown default:
            print("  - Unknown decoding error")
        }
    }

    private func printSuccess() {
        print("✅ ========== Success ==========")
        print("🎉 Request completed successfully!")
        print("================================\n")
    }
}
