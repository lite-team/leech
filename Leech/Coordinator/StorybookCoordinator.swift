//
//  StorybookCoordinator.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/19/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

final class StorybookCoordinator: Coordinatable {

    weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    private let componentSection = StorybookCategory(title: "Component", items: [
        StorybookItem(classType: TwoRowsInfoView.self)
    ])

    func start(onFinish: (() -> Void)?) {
        let rootViewController = StorybookViewController(
            model: StorybookViewController.Model(categories: [
                componentSection
                ]))

        window?.rootViewController = rootViewController
    }
}
