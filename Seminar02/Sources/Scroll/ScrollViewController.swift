//
//  ScrollViewController.swift
//  Seminar02
//
//  Created by 이명진 on 10/18/25.
//

import Foundation
import SnapKit
import UIKit

class ScrollViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private var contentView = UIView()
    
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }

    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [greenView, blueView].forEach {
            contentView.addSubview($0)
        }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            // 이게모게
            $0.height.greaterThanOrEqualToSuperview().priority(.low) // contentView의 height가 scrollView의 height보다 크거나 같도록 설정합니다. 우선순위는 낮습니다.
        }
        
        greenView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(200)
        }
        
        blueView.snp.makeConstraints {
            $0.top.equalTo(greenView.snp.bottom)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(200)
            $0.bottom.equalTo(contentView) // contentView의 마지막 요소로, bottom을 설정합니다.
        }
    }
}

#Preview {
    ScrollViewController()
}
