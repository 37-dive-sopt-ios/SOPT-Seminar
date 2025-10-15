//
//  UITextField+.swift
//  Core
//
//  Created by 이명진 on 10/15/25.
//

import UIKit

public extension UITextField {
    
    /// 텍스트 필드에 왼쪽 패딩을 추가합니다.
    public func addLeftPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    /// 텍스트 필드에 오른쪽 패딩을 추가합니다.
    public func addRightPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    /// 텍스트 필드에 좌우 패딩을 한 번에 추가합니다.
    public func addPadding(leftAmount: CGFloat = 10, rightAmount: CGFloat = 10) {
        addLeftPadding(leftAmount)
        addRightPadding(rightAmount)
    }
    
    // 사용 예시
    // myTextField.addPadding(left: 20, right: 20)
    // myTextField.addPadding()
}
