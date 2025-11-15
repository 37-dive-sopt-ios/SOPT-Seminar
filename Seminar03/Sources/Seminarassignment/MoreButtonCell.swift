//
//  MoreButtonCell.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit
import SnapKit
import Core

final class MoreButtonCell: UICollectionViewCell {

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        view.layer.cornerRadius = 8
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        containerView.addSubviews(
            titleLabel,
            chevronImageView
        )

        contentView.addSubview(containerView)
    }

    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        chevronImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(14)
        }
    }

    // MARK: - Configuration

    func configure(title: String) {
        titleLabel.text = title
    }
}
