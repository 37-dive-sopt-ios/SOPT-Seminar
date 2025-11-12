//
//  BaeminTabBarController.swift
//  Seminar03
//
//  Created by 이명진 on 11/12/25.
//

import UIKit

public final class BaeminTabBarController: UITabBarController {

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setViewControllers()
    }

    // MARK: - UI Setup

    private func setUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "baeminMain") ?? .systemCyan
        tabBar.unselectedItemTintColor = .systemGray
    }

    private func setViewControllers() {
        let homeVC = MainViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let shoppingVC = createSimpleViewController(
            title: "장보기·쇼핑",
            backgroundColor: .systemGreen
        )
        shoppingVC.tabBarItem = UITabBarItem(
            title: "장보기·쇼핑",
            image: UIImage(systemName: "cart"),
            selectedImage: UIImage(systemName: "cart.fill")
        )

        let favoriteVC = createSimpleViewController(
            title: "찜",
            backgroundColor: .systemPink
        )
        favoriteVC.tabBarItem = UITabBarItem(
            title: "찜",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )

        let orderHistoryVC = createSimpleViewController(
            title: "주문내역",
            backgroundColor: .systemOrange
        )
        orderHistoryVC.tabBarItem = UITabBarItem(
            title: "주문내역",
            image: UIImage(systemName: "doc.text"),
            selectedImage: UIImage(systemName: "doc.text.fill")
        )

        let myPageVC = createSimpleViewController(
            title: "마이배민",
            backgroundColor: .systemGray
        )
        myPageVC.tabBarItem = UITabBarItem(
            title: "마이배민",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [homeVC, shoppingVC, favoriteVC, orderHistoryVC, myPageVC]
    }

    // MARK: - Helper

    private func createSimpleViewController(
        title: String,
        backgroundColor: UIColor
    ) -> UIViewController {
        let vc = SimpleColorViewController(title: title, backgroundColor: backgroundColor)
        return vc
    }
}

// MARK: - SimpleColorViewController

private final class SimpleColorViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let backgroundColor: UIColor

    init(title: String, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
