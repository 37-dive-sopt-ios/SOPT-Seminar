//
//  Responsable.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// API 응답을 디코딩하는 프로토콜
public protocol Responsable: Decodable {
    /// 응답이 성공인지 확인
    var isSuccess: Bool { get }
}

/// 기본 응답 래퍼 (서버의 공통 응답 형식)
public struct BaseResponse<T: Decodable>: Responsable {
    public let success: Bool
    public let code: String?
    public let message: String?
    public let data: T?

    public var isSuccess: Bool {
        return success
    }
}

/// 응답 데이터가 없는 경우를 위한 Empty 타입
public struct EmptyResponse: Decodable {
    public init() {}
}
