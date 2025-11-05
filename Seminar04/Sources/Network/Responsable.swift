//
//  Responsable.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// 기본 응답 래퍼 (서버의 공통 응답 형식)
public struct BaseResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let code: String?
    public let message: String?
    public let data: T?
}

/// 응답 데이터가 없는 경우를 위한 Empty 타입
public struct EmptyResponse: Decodable {
    public init() {}
}
