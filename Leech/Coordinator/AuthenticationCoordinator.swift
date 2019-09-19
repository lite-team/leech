//
//  AuthenticationCoordinator.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

final class AuthenticationCoordinator: Coordinatable {
    private weak var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start(onFinish: (() -> Void)?) {
        let rootViewController = UIViewController()
        rootViewController.view.backgroundColor = .blue
        window?.rootViewController = rootViewController
    }
}
