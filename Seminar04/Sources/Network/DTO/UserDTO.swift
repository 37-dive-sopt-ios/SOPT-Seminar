//
//  UserDTO.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// 사용자 정보 응답 모델
public struct UserResponse: Decodable {
    public let id: Int
    public let username: String
    public let name: String
    public let email: String
    public let age: Int
    public let status: String
}

/// 회원가입 요청 모델
public struct RegisterRequest: Encodable {
    public let username: String
    public let password: String
    public let name: String
    public let email: String
    public let age: Int
}

/// 로그인 요청 모델
public struct LoginRequest: Encodable {
    public let username: String
    public let password: String
}

/// 로그인 응답 모델
public struct LoginResponse: Decodable {
    public let userId: Int
    public let message: String
}

/// 개인정보 수정 요청 모델
public struct UpdateUserRequest: Encodable {
    public let name: String?
    public let email: String?
    public let age: Int?
}
