//
//  HomeViewPresenter.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

final class HomeViewPresenter {
}

extension HomeViewPresenter {
    enum Component {
        static var `default`: HomeViewPresenter {
            return HomeViewPresenter()
        }
    }
}

// MARK: - Actions
extension HomeViewPresenter: HomeViewAction {
    func viewDidLoad() {
        
    }
}

// MARK: - States
extension HomeViewPresenter: HomeViewState {
    var spentPerDay: Observable<String> {
        return Observable.just("100$")
    }
}

// MARK: - Presentable
extension HomeViewPresenter: HomeViewPresentable {
    var action: HomeViewAction {
        return self
    }

    var state: HomeViewState {
        return self
    }
}
