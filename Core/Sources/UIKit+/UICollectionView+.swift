//
//  UICollectionView+.swift
//  Core
//
//  Created by 이명진 on 11/13/25.
//

import UIKit

// MARK: - Cell Registration & Dequeue

public extension UICollectionView {

    /// 타입 안전한 Cell 등록
    /// - Parameter cellType: 등록할 Cell 타입
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        let identifier = String(describing: cellType)
        register(cellType, forCellWithReuseIdentifier: identifier)
    }

    /// 타입 안전한 Cell dequeue
    /// - Parameters:
    ///   - cellType: dequeue할 Cell 타입
    ///   - indexPath: Cell의 IndexPath
    /// - Returns: 지정된 타입의 Cell 인스턴스
    func dequeueReusableCell<T: UICollectionViewCell>(
        _ cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue \(cellType) with identifier \(identifier)")
        }
        return cell
    }
}

// MARK: - Header/Footer Registration & Dequeue

public extension UICollectionView {

    /// 타입 안전한 SupplementaryView 등록
    /// - Parameters:
    ///   - viewType: 등록할 View 타입
    ///   - kind: Supplementary View의 kind (UICollectionView.elementKindSectionHeader 등)
    func registerSupplementaryView<T: UICollectionReusableView>(
        _ viewType: T.Type,
        ofKind kind: String
    ) {
        let identifier = String(describing: viewType)
        register(
            viewType,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: identifier
        )
    }

    /// 타입 안전한 SupplementaryView dequeue
    /// - Parameters:
    ///   - viewType: dequeue할 View 타입
    ///   - kind: Supplementary View의 kind
    ///   - indexPath: View의 IndexPath
    /// - Returns: 지정된 타입의 View 인스턴스
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        _ viewType: T.Type,
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> T {
        let identifier = String(describing: viewType)
        guard let view = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? T else {
            fatalError("Unable to dequeue \(viewType) with identifier \(identifier)")
        }
        return view
    }
}
