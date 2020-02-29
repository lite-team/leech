//
//  LeechNavigationController.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

class LeechNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        navigationBar.barTintColor = .white
        navigationBar.tintColor = R.color.urbanGrey80()
        navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
