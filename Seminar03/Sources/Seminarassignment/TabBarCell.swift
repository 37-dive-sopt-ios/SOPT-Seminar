//
//  TabBarCell.swift
//  Seminar03
//
//  Created by 이명진 on 11/13/25.
//

import UIKit
import SnapKit
import Core

protocol TabBarCellDelegate: AnyObject {
    func tabBarCell(_ cell: TabBarCell, didSelectTabAt index: Int)
}

final class TabBarCell: UICollectionViewCell {

    // MARK: - Properties

    weak var delegate: TabBarCellDelegate?
    private var currentIndex: Int = 0
    private var tabButtons: [UIButton] = []

    // MARK: - UI Components

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return view
    }()

    private var indicatorLeadingConstraint: Constraint?
    private var indicatorWidthConstraint: Constraint?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setHierarchy()
        setLayout()
        setupTabs()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setUI() {
        contentView.backgroundColor = .white
    }

    private func setHierarchy() {
        contentView.addSubviews(
            stackView,
            indicatorView,
            bottomLine
        )
    }

    private func setLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        indicatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2)
            indicatorLeadingConstraint = $0.leading.equalToSuperview().constraint
            indicatorWidthConstraint = $0.width.equalTo(0).constraint
        }

        bottomLine.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    private func setupTabs() {
        let titles = ["음식배달", "픽업", "장보기·쇼핑", "선물하기", "혜택모아"]

        titles.enumerated().forEach { index, title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.systemGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped), for: .touchUpInside)

            tabButtons.append(button)
            stackView.addArrangedSubview(button)
        }

        selectTab(at: 0)
    }

    @objc private func tabTapped(_ sender: UIButton) {
        selectTab(at: sender.tag)
        delegate?.tabBarCell(self, didSelectTabAt: sender.tag)
    }

    // MARK: - Public Methods

    func selectTab(at index: Int) {
        guard index < tabButtons.count else { return }

        tabButtons[currentIndex].isSelected = false
        currentIndex = index
        tabButtons[index].isSelected = true

        updateIndicator(for: index)
    }

    private func updateIndicator(for index: Int) {
        let buttonWidth = contentView.bounds.width / CGFloat(tabButtons.count)
        let leading = buttonWidth * CGFloat(index)

        indicatorLeadingConstraint?.update(offset: leading)
        indicatorWidthConstraint?.update(offset: buttonWidth)

        UIView.animate(withDuration: 0.3) {
            self.contentView.layoutIfNeeded()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if indicatorWidthConstraint?.layoutConstraints.first?.constant == 0 {
            updateIndicator(for: currentIndex)
        }
    }
}
