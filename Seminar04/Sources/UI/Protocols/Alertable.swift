//
//  Alertable.swift
//  Seminar04
//
//  Created by 이명진 on 10/31/25.
//

import UIKit

/// Alert를 표시할 수 있는 기능을 정의하는 프로토콜 (POP)
public protocol Alertable: AnyObject {
    /// Alert를 표시합니다
    /// - Parameters:
    ///   - title: Alert 제목
    ///   - message: Alert 메시지
    ///   - completion: 확인 버튼 클릭 시 실행될 클로저 (Optional)
    func showAlert(title: String, message: String, completion: (() -> Void)?)
}

// MARK: - 기본 구현

public extension Alertable where Self: UIViewController {
    /// Alert 기본 구현 (UIViewController를 준수하는 타입만)
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        self.present(alert, animated: true)
    }
}
