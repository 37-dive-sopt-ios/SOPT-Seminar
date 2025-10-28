//
//  WelcomeViewController_MVC.swift
//  Seminar03
//
//  Created by 이명진 on 10/24/25.
//

import UIKit
import SnapKit

public final class WelcomeViewController_MVC: UIViewController {

    var id: String?

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo2")
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "???님 \n반가워요!"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 25)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private var goHomeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 15/255, alpha: 1)
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        return button
    }()

    private lazy var backToLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 221/255, green: 222/255, blue: 227/255, alpha: 1)
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(UIColor(red: 172/255, green: 176/255, blue: 185/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        return button
    }()

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()

        bindID()
    }

    private func setUI() {
        self.view.backgroundColor = .white
    }

    private func setLayout() {
        [logoImageView, welcomeLabel, goHomeButton, backToLoginButton].forEach {
            self.view.addSubview($0)
        }

        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(87)
            $0.width.height.equalTo(150)
        }

        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(58)
            $0.width.equalTo(95)
            $0.height.equalTo(60)
        }

        goHomeButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(73)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }

        backToLoginButton.snp.makeConstraints {
            $0.top.equalTo(goHomeButton.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(58)
        }
    }

    private func bindID() {
        guard let id = id else { return }
        self.welcomeLabel.text = "\(id)님 \n반가워요!"
    }

    @objc
    private func backToLoginButtonDidTap() {
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
