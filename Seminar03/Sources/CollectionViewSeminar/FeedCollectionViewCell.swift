//
//  FeedCollectionViewCell.swift
//  Seminar03
//
//  Created by 이명진 on 10/27/25.
//

import UIKit
import SnapKit
import Core

public final class FeedCollectionViewCell: UICollectionViewCell {

    public static let identifier: String = "FeedCollectionViewCell"

    // MARK: - UI Components

    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .orange
        return label
    }()

    private let scrapButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_scrap"), for: .normal)
        button.setImage(UIImage(named: "ic_scrap_fill"), for: .selected)
        return button
    }()

    // MARK: - Properties

    private var scrapAction: (() -> Void)?

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        setActions()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUI() {
        contentView.backgroundColor = .white
    }

    private func setHierarchy() {
        contentView.addSubviews(
            itemImageView,
            nameLabel,
            priceLabel,
            scrapButton
        )
    }

    private func setLayout() {
        itemImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(itemImageView.snp.width)
        }

        scrapButton.snp.makeConstraints {
            $0.trailing.equalTo(itemImageView).inset(8)
            $0.bottom.equalTo(itemImageView).inset(8)
            $0.size.equalTo(24)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.horizontalEdges.equalToSuperview()
        }
    }

    private func setActions() {
        scrapButton.addTarget(self, action: #selector(scrapButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func scrapButtonTapped() {
        scrapButton.isSelected.toggle()
        scrapAction?()
    }

    // MARK: - Configuration

    public func configure(with feed: FeedModel, scrapAction: @escaping () -> Void) {
        itemImageView.image = feed.itemImg
        nameLabel.text = feed.name
        priceLabel.text = feed.price
        scrapButton.isSelected = feed.isScrap
        self.scrapAction = scrapAction
    }
}
