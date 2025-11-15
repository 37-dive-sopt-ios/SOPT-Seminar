//
//  CategoryCell.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit
import SnapKit
import Core

final class CategoryCell: UICollectionViewCell {

    // MARK: - UI Components

    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 25
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUI() {
        contentView.backgroundColor = .white
    }

    private func setHierarchy() {
        iconBackgroundView.addSubview(iconImageView)

        contentView.addSubviews(
            iconBackgroundView,
            titleLabel
        )
    }

    private func setLayout() {
        iconBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(26)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconBackgroundView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
        }
    }

    // MARK: - Configuration

    func configure(title: String, iconName: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: iconName)
    }
}
