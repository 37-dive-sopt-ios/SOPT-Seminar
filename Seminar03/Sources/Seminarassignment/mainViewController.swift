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
    private var currentTabIndex: Int = 0
    private weak var tabBarCell: TabBarCell?

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
        let layout = BaeminLayout.createLayout(for: sections) { [weak self] scrollProgress in
            guard let self = self else { return }
            // 실시간 스크롤 진행률로 탭 업데이트
            self.updateTabFromScrollProgress(scrollProgress)
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchBarCell.self)
        collectionView.register(BannerCell.self)
        collectionView.register(TabBarCell.self)
        collectionView.register(PagingContentCell.self)
    }

    // MARK: - Helper Methods

    private func updateTabFromScrollProgress(_ scrollProgress: CGFloat) {
        let pageIndex = Int(round(scrollProgress))
        if pageIndex != currentTabIndex && pageIndex >= 0 {
            currentTabIndex = pageIndex
            tabBarCell?.selectTab(at: currentTabIndex)
        }
    }

    // MARK: - Data Setup

    private func setupSections() {
        let pageContents: [PageContent] = [
            // 음식배달
            PageContent(
                categories: [
                    ("한식", "leaf.fill"),
                    ("분식", "flame.fill"),
                    ("카페·디저트", "cup.and.saucer.fill"),
                    ("돈까스·회·일식", "fish.fill"),
                    ("치킨", "fork.knife"),
                    ("피자", "circle.grid.cross.fill"),
                    ("아시안", "globe.asia.australia.fill"),
                    ("양식", "fork.knife.circle.fill"),
                    ("중식", "bowl.fill"),
                    ("족발·보쌈", "flame.circle.fill")
                ],
                hasMoreButton: true,
                moreButtonTitle: "음식배달에서 더보기"
            ),
            // 픽업
            PageContent(
                categories: [
                    ("1인분", "person.fill"),
                    ("한식", "leaf.fill"),
                    ("치킨", "fork.knife"),
                    ("피자", "circle.grid.cross.fill"),
                    ("카페", "cup.and.saucer.fill"),
                    ("패스트푸드", "takeoutbag.and.cup.and.straw.fill"),
                    ("아시안", "globe.asia.australia.fill"),
                    ("분식", "flame.fill"),
                    ("중식", "bowl.fill"),
                    ("샐러드", "carrot.fill")
                ],
                hasMoreButton: true,
                moreButtonTitle: "픽업에서 더보기"
            ),
            // 장보기·쇼핑
            PageContent(
                categories: [
                    ("B마트", "bag.fill"),
                    ("전국별미", "map.fill"),
                    ("편의점", "storefront.fill"),
                    ("쓱세일", "tag.fill"),
                    ("채소·과일·쌀", "basket.fill"),
                    ("정육·계란", "flame.fill"),
                    ("수산·건해산", "fish.fill"),
                    ("우유·유제품", "drop.fill"),
                    ("김치·반찬", "takeoutbag.and.cup.and.straw.fill"),
                    ("생활용품", "house.fill")
                ],
                hasMoreButton: false,
                moreButtonTitle: ""
            ),
            // 선물하기
            PageContent(
                categories: [
                    ("전체선물", "gift.fill"),
                    ("배달선물", "shippingbox.fill"),
                    ("배민B마트선물", "bag.circle.fill"),
                    ("브랜드선물", "star.fill"),
                    ("카페·디저트", "cup.and.saucer.fill"),
                    ("베이커리·케이크", "birthday.cake.fill"),
                    ("치킨·피자", "circle.grid.cross.fill"),
                    ("한우·육류", "flame.fill"),
                    ("과일", "leaf.fill"),
                    ("건강식품", "heart.fill")
                ],
                hasMoreButton: false,
                moreButtonTitle: ""
            ),
            // 혜택모아
            PageContent(
                categories: [
                    ("전체혜택", "sparkles"),
                    ("쿠폰", "ticket.fill"),
                    ("할인", "percent"),
                    ("포인트", "dollarsign.circle.fill"),
                    ("무료배달", "truck.box.fill"),
                    ("이벤트", "calendar.badge.exclamationmark"),
                    ("멤버십", "crown.fill"),
                    ("첫주문", "star.circle.fill"),
                    ("리뷰", "text.bubble.fill"),
                    ("친구초대", "person.2.fill")
                ],
                hasMoreButton: false,
                moreButtonTitle: ""
            )
        ]

        sections = [
            .searchBar,
            .banner(BannerItem(
                title: "B마트🎱",
                subtitle: "전상품 쿠폰팩 + 60%특가",
                backgroundColor: "#A0E7E5"
            )),
            .tabBar,
            .pagingContent(pageContents)
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
        case .tabBar:
            return 1
        case .pagingContent(let pages):
            return pages.count
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

        case .tabBar:
            let cell = collectionView.dequeueReusableCell(TabBarCell.self, for: indexPath)
            cell.delegate = self
            tabBarCell = cell
            cell.selectTab(at: currentTabIndex)
            return cell

        case .pagingContent(let pages):
            let cell = collectionView.dequeueReusableCell(PagingContentCell.self, for: indexPath)
            let page = pages[indexPath.item]
            cell.configure(
                categories: page.categories,
                hasMoreButton: page.hasMoreButton,
                moreButtonTitle: page.moreButtonTitle
            )
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
    // Delegate methods can be added here if needed
}

// MARK: - TabBarCellDelegate

extension MainViewController: TabBarCellDelegate {
    func tabBarCell(_ cell: TabBarCell, didSelectTabAt index: Int) {
        currentTabIndex = index

        // pagingContent 섹션 찾기
        guard let pagingContentSectionIndex = sections.firstIndex(where: {
            if case .pagingContent = $0 { return true }
            return false
        }) else { return }

        // 해당 페이지로 스크롤
        let indexPath = IndexPath(item: index, section: pagingContentSectionIndex)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


#Preview {
    BaeminTabBarController()
}
