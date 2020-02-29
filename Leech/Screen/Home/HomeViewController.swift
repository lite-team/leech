//
//  HomeViewController.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

// MARK: - Life cycle
final class HomeViewController: LeechViewController {

    private let presenter: HomeViewPresentable

    required init(presenter: HomeViewPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        isTransparent = true
        setupState()
    }

    override var rightNavigationItems: [UIBarButtonItem]? {
        return [
            UIBarButtonItem(title: "NGHIA", style: .plain, target: nil, action: nil)
        ]
    }
}

// MARK: - Private functions
extension HomeViewController {
    private func setupState() {
        presenter.state.spentPerDay.weakSubscribe(self, onNext: { (a, spentPerDay) in
            print("NGHIA: \(spentPerDay)")
        }).disposed(by: disposeBag)
    }
}

// MARK: - Public functions

// MARK: - Components
extension HomeViewController {
    enum Component {
        static var `default`: HomeViewController {
            return HomeViewController(presenter: HomeViewPresenter.Component.default)
        }
    }
}
