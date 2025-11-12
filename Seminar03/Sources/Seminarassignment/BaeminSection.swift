//
//  BaeminSection.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import Foundation

// MARK: - BaeminSection

enum BaeminSection {
    case searchBar
    case banner(BannerItem)
    case categoryGrid([CategoryItem])
    case actionButton(ActionButtonItem)
    case brandRow([BrandItem])
}

// MARK: - Models

struct BannerItem {
    let title: String
    let subtitle: String
    let backgroundColor: String
}

struct CategoryItem {
    let title: String
    let iconName: String
}

struct ActionButtonItem {
    let title: String
}

struct BrandItem {
    let name: String
    let iconName: String
}
