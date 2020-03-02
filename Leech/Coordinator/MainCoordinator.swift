//
//  MainCoordinator.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinatable {
    weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start(onFinish: (() -> Void)?) {
        let rootViewController = MainTabViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
