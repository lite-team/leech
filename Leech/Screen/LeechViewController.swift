//
//  LeechViewController.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

class LeechViewController: BaseViewController {

    override var leftNavigationItems: [UIBarButtonItem]? {
        if (navigationController?.viewControllers.count).map({ $0 > 1 }) == true, let backButtonImage = R.image.back()?.withRenderingMode(.alwaysTemplate) {
            return [
                UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(didTapBackButton))
            ]
        } else {
            return nil
        }
    }

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    private func setupViewController() {
        view.backgroundColor = appTheme.backgroundColor
        currentNavigationItem.largeTitleDisplayMode = .never
        fakeNavigationBar.tintColor = R.color.urbanGrey80()
    }
}
