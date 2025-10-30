//
//  DiffableViewController.swift
//  Seminar03
//
//  Created by 이명진 on 10/28/25.
//

import UIKit
import Core
import SnapKit

public final class DiffableViewController: UIViewController {

    // MARK: - Section

    enum Section {
        case main
    }

    // MARK: - Properties

    private var items: [ItemModel] = ItemModel.mockData
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemModel>!

    // MARK: - UI Components

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierarchy()
        setLayout()
        setActions()
        configureDataSource()
        applyInitialSnapshot()
    }

    // MARK: - UI Setup

    private func setUI() {
        view.backgroundColor = .white
        title = "Diffable DataSource"
    }

    private func setHierarchy() {
        view.addSubviews(collectionView, addButton, deleteButton)
    }

    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(addButton.snp.top).offset(-16)
        }

        addButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(150)
        }

        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(150)
        }
    }

    private func setActions() {
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    // MARK: - Layout

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    // MARK: - Diffable DataSource

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ItemCollectionViewCell, ItemModel> { cell, indexPath, item in
            cell.configure(with: item)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, ItemModel>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }

    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - CRUD Actions

    @objc private func addButtonTapped() {
        let newItem = ItemModel(
            title: "새 아이템 \(items.count + 1)",
            subtitle: "\(items.count + 1)번째로 추가된 아이템"
        )
        items.append(newItem)

        var snapshot = dataSource.snapshot()
        snapshot.appendItems([newItem], toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc private func deleteButtonTapped() {
        guard !items.isEmpty else { return }

        let removedItem = items.removeLast()

        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([removedItem])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
