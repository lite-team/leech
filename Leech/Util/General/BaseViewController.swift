//
//  BaseViewController.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit
import RxSwift

public class BaseViewController: UIViewController {

    // MARK: - Public variables
    public let disposeBag = DisposeBag()
    public var isTransparent = false {
        didSet {
            self.setupNavigationBar()
        }
    }

    // MARK: - Private variables
    private(set) lazy var fakeNavigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.isTranslucent = true
        bar.shadowImage = UIImage()
        bar.isHidden = true
        bar.delegate = self
        bar.items = [self.fakeNavigationItem]
        return bar
    }()

    private let fakeNavigationItem = UINavigationItem()

    private func setupFakeNavigationBar() {
        view.addSubview(fakeNavigationBar)

        fakeNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        fakeNavigationBar.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        fakeNavigationBar.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        fakeNavigationBar.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - Public functions
@objc
extension BaseViewController {
    public var currentNavigationItem: UINavigationItem {
        return isTransparent ? fakeNavigationItem : navigationItem
    }

    public var currentNavigationBar: UINavigationBar? {
        return isTransparent ? fakeNavigationBar : navigationController?.navigationBar
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        setupView()
        setupFakeNavigationBar()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
    }

    public func setupNavigationItems() {
        navigationItem.leftBarButtonItems = leftNavigationItems
        navigationItem.rightBarButtonItems = rightNavigationItems
        navigationItem.titleView = titleNavigationItem

        fakeNavigationItem.leftBarButtonItems = leftNavigationItems
        fakeNavigationItem.rightBarButtonItems = rightNavigationItems
        fakeNavigationItem.titleView = titleNavigationItem
    }

    public var leftNavigationItems: [UIBarButtonItem]? {
        return nil
    }

    public var rightNavigationItems: [UIBarButtonItem]? {
        return nil
    }

    public var titleNavigationItem: UIView? {
        return nil
    }

    public func setupView() {}

    public func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(isTransparent, animated: true)
        fakeNavigationBar.isHidden = !isTransparent
        fakeNavigationBar.isUserInteractionEnabled = isTransparent
        if isTransparent {
            view.bringSubviewToFront(fakeNavigationBar)
        }
    }

    public func enableLargeTitle(_ title: String?) {
        if let title = title {
            self.title = title
            currentNavigationItem.largeTitleDisplayMode = .always
        } else {
            currentNavigationItem.largeTitleDisplayMode = .never
        }
    }
}

extension BaseViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
