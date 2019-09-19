//
//  AppCoordinator.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinatable {
    private let authenticationCoordinator: Coordinatable
    private let mainCoordinator: Coordinatable
    private let storybookCoordinator: Coordinatable

    private let isAuthenticatedWorker: Worker<Void?, Bool>
    private let isStorybookTriggeredWorker: Worker<Void?, Bool>

    private let disposeBag = DisposeBag()

    init(
        isStorybookTriggeredWorker: Worker<Void?, Bool>,
        isAuthenticatedWorker: Worker<Void?, Bool>,
        authenticationCoordinator: Coordinatable,
        mainCoordinator: Coordinatable,
        storybookCoordinator: Coordinatable) {

        self.authenticationCoordinator = authenticationCoordinator
        self.mainCoordinator = mainCoordinator
        self.isAuthenticatedWorker = isAuthenticatedWorker
        self.isStorybookTriggeredWorker = isStorybookTriggeredWorker
        self.storybookCoordinator = storybookCoordinator
    }

    func start(onFinish: (() -> Void)?) {

        Observable.zip (
            isStorybookTriggeredWorker.execute(payload: nil),
            isAuthenticatedWorker.execute(payload: nil))
            .weakSubscribe(self, onNext: { (obj, checker) in

                switch checker {
                case (true, _):
                    obj.storybookCoordinator.start(onFinish: nil)
                case (false, true):
                    obj.mainCoordinator.start(onFinish: nil)
                default:
                    obj.authenticationCoordinator.start(onFinish: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AppCoordinator {
    enum Component {
        static func `default`(window: UIWindow?) -> AppCoordinator {
            return AppCoordinator(
                isStorybookTriggeredWorker: Worker.just(true),
                isAuthenticatedWorker: Worker { _ in AuthenticationManager.shared.isAuthenticated.toObservable
                },
                authenticationCoordinator: AuthenticationCoordinator(window: window),
                mainCoordinator: MainCoordinator(window: window),
                storybookCoordinator: StorybookCoordinator(window: window))
        }

        static func test(window: UIWindow?) -> AppCoordinator {
            return AppCoordinator(
                isStorybookTriggeredWorker: Worker.just(true),
                isAuthenticatedWorker: Worker { _ in false.toObservable },
                authenticationCoordinator: AuthenticationCoordinator(window: window),
                mainCoordinator: MainCoordinator(window: window),
                storybookCoordinator: StorybookCoordinator(window: window))
        }
    }
}
