//
//  MainTabViewController.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

final class MainTabViewController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        setupViewControllers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let addingViewController = UIViewController()

    private func setupViewControllers() {
        let homeViewController = LeechNavigationController(
            rootViewController: HomeViewController.Component.default)
        homeViewController.view.backgroundColor = appTheme.backgroundColor

        homeViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: R.image.homeTab(),
            selectedImage: R.image.homeTabSelected())

        let stuffViewController = UIViewController()

        stuffViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: R.image.stuffTab(),
            selectedImage: R.image.stuffTabSelected())

        addingViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: R.image.addTab()?.withRenderingMode(.alwaysOriginal),
            selectedImage: R.image.addTab()?.withRenderingMode(.alwaysOriginal))

        let notificationViewController = UIViewController()

        notificationViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: R.image.notificationTab(),
            selectedImage: R.image.notificationTabSelected())

        let profileViewController = UIViewController()

        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: R.image.profileTab(),
            selectedImage: R.image.profileTabSelected())

        viewControllers = [
            homeViewController,
            stuffViewController,
            addingViewController,
            notificationViewController,
            profileViewController
        ]

        viewControllers?.forEach {
            $0.tabBarItem.imageInsets = UIEdgeInsets(top: C.Spacing.medium, left: 0, bottom: -C.Spacing.medium, right: 0)
        }

        tabBar.tintColor = appTheme.primaryColor
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        tabBar.itemPositioning = .centered
        delegate = self
    }
}

extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController === addingViewController {
            return false
        }

        return true
    }
}
