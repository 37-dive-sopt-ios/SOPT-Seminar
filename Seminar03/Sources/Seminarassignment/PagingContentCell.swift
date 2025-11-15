//
//  PagingContentCell.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit
import SnapKit
import Core

final class PagingContentCell: UICollectionViewCell {

    // MARK: - Properties

    private var categories: [(title: String, iconName: String)] = []
    private var hasMoreButton: Bool = false
    private var moreButtonTitle: String = ""

    // MARK: - UI Components

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self)
        collectionView.register(MoreButtonCell.self)
        collectionView.isScrollEnabled = false
        return collectionView
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
        contentView.addSubview(collectionView)
    }

    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Layout

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else { return nil }

            if sectionIndex == 0 {
                return self.createCategorySection()
            } else {
                return self.createMoreButtonSection()
            }
        }
    }

    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 5
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 8,
            trailing: 16
        )

        return section
    }

    private func createMoreButtonSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    // MARK: - Configuration

    func configure(categories: [(String, String)], hasMoreButton: Bool, moreButtonTitle: String) {
        self.categories = categories
        self.hasMoreButton = hasMoreButton
        self.moreButtonTitle = moreButtonTitle
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension PagingContentCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return hasMoreButton ? 2 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(CategoryCell.self, for: indexPath)
            let category = categories[indexPath.item]
            cell.configure(title: category.title, iconName: category.iconName)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(MoreButtonCell.self, for: indexPath)
            cell.configure(title: moreButtonTitle)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension PagingContentCell: UICollectionViewDelegate {}
