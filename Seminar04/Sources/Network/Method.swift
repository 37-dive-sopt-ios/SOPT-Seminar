//
//  Method.swift
//  Seminar04
//
//  Created by 이명진 on 10/30/25.
//

import Foundation

/// HTTP 메서드 (Moya의 Method와 동일!)
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
