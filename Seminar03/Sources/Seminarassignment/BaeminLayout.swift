//
//  BaeminLayout.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit

struct BaeminLayout {

    // MARK: - Main Layout

    static func createLayout(for sections: [BaeminSection]) -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            guard sectionIndex < sections.count else { return nil }

            let section = sections[sectionIndex]
            return createSection(for: section, environment: environment)
        }
    }

    // MARK: - Section Factory

    private static func createSection(
        for sectionType: BaeminSection,
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        switch sectionType {
        case .searchBar:
            return createSearchBarSection()
        case .banner:
            return createBannerSection()
        case .categoryGrid:
            return createCategoryGridSection()
        case .actionButton:
            return createActionButtonSection()
        case .brandRow:
            return createBrandRowSection()
        }
    }

    // MARK: - Search Bar Section

    private static func createSearchBarSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(83)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    // MARK: - Banner Section

    private static func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        return section
    }

    // MARK: - Category Grid Section (2열 수평 스크롤)

    private static func createCategoryGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(90)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(180)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            repeatingSubitem: item,
            count: 2
        )

        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        return section
    }

    // MARK: - Action Button Section

    private static func createActionButtonSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 0,
            bottom: 8,
            trailing: 0
        )
        return section
    }

    // MARK: - Brand Row Section (1열 수평 스크롤)

    private static func createBrandRowSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        return section
    }
}
