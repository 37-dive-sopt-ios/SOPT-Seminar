//
//  UIView+.swift
//  Core
//
//  Created by 이명진 on 10/16/25.
//

import UIKit

public extension UIView {
    
    /// UIView 여러 개 인자로 받아서 한 번에 addSubview 합니다.
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
