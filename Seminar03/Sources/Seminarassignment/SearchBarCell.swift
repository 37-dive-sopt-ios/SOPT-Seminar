//
//  SearchBarCell.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit
import SnapKit
import Core

final class SearchBarCell: UICollectionViewCell {

    // MARK: - UI Components

    private let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("우리집 ▼", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()

    private let searchBarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.layer.cornerRadius = 20
        return view
    }()

    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let searchPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "찾아라! 맛있는 음식과 맛집"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()

    private let iconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    private let starButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = UIColor(named: "baeminMain") ?? .systemCyan
        return button
    }()

    private let bellButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.tintColor = .black
        return button
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
        iconStackView.addArrangedSubview(starButton)
        iconStackView.addArrangedSubview(bellButton)
        iconStackView.addArrangedSubview(cartButton)

        searchBarContainer.addSubviews(
            searchIconImageView,
            searchPlaceholderLabel
        )

        contentView.addSubviews(
            locationButton,
            searchBarContainer,
            iconStackView
        )
    }

    private func setLayout() {
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.leading.equalToSuperview().inset(16)
        }

        iconStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.trailing.equalToSuperview().inset(16)
        }

        starButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }

        bellButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }

        cartButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }

        searchBarContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(43)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }

        searchIconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }

        searchPlaceholderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
