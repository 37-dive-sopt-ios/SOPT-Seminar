//
//  UserDTO.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

// MARK: - User Response Model

/// 사용자 정보 응답 모델
public struct UserResponse: Decodable {
    public let id: Int
    public let username: String
    public let name: String
    public let email: String
    public let age: Int
    public let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case email
        case age
        case status
    }
}

// MARK: - Register Request Model

/// 회원가입 요청 모델
public struct RegisterRequest: Encodable {
    public let username: String
    public let password: String
    public let name: String
    public let email: String
    public let age: Int

    public init(username: String, password: String, name: String, email: String, age: Int) {
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.age = age
    }
}

// MARK: - Login Request/Response Models

/// 로그인 요청 모델
public struct LoginRequest: Encodable {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

/// 로그인 응답 모델
public struct LoginResponse: Decodable {
    public let userId: Int
    public let message: String
}

// MARK: - Update User Request Model

/// 개인정보 수정 요청 모델
public struct UpdateUserRequest: Encodable {
    public let name: String?
    public let email: String?
    public let age: Int?

    public init(name: String? = nil, email: String? = nil, age: Int? = nil) {
        self.name = name
        self.email = email
        self.age = age
    }
}
