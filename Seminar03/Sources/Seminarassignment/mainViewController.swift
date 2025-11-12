//
//  mainViewController.swift
//  Seminar03
//
//  Created by 이명진 on 11/12/25.
//

import UIKit
import SnapKit
import Core

public final class MainViewController: UIViewController {

    // MARK: - Properties

    private var sections: [BaeminSection] = []

    // MARK: - UI Components

    private var collectionView: UICollectionView!

    // MARK: - Initialization

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSections()
        setupCollectionView()
        setUI()
        setHierarchy()
        setLayout()
    }

    // MARK: - UI Setup

    private func setUI() {
        view.backgroundColor = .white
    }

    private func setHierarchy() {
        view.addSubview(collectionView)
    }

    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - CollectionView Setup

    private func setupCollectionView() {
        let layout = BaeminLayout.createLayout(for: sections)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchBarCell.self)
        collectionView.register(BannerCell.self)
    }

    // MARK: - Data Setup

    private func setupSections() {
        sections = [
            .searchBar,
            .banner(BannerItem(
                title: "B마트🎱",
                subtitle: "전상품 쿠폰팩 + 60%특가",
                backgroundColor: "#A0E7E5"
            ))
        ]
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch sections[section] {
        case .searchBar:
            return 1
        case .banner:
            return 1
        case .categoryGrid(let items):
            return items.count
        case .actionButton:
            return 1
        case .brandRow(let items):
            return items.count
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .searchBar:
            return collectionView.dequeueReusableCell(SearchBarCell.self, for: indexPath)

        case .banner(let item):
            let cell = collectionView.dequeueReusableCell(BannerCell.self, for: indexPath)
            cell.configure(with: item)
            return cell

        case .categoryGrid:
            // TODO: 나중에 CategoryCell 구현
            return UICollectionViewCell()

        case .actionButton:
            // TODO: 나중에 ActionButtonCell 구현
            return UICollectionViewCell()

        case .brandRow:
            // TODO: 나중에 BrandCell 구현
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    // TODO: 필요시 delegate 메서드 추가
}


#Preview {
    BaeminTabBarController()
}
