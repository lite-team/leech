//
//  AppDelegate.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = AppCoordinator.Component.default(window: window)
        appCoordinator?.start(onFinish: nil) 

        return true
    }
}
