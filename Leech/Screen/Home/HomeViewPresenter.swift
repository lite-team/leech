//
//  HomeViewPresenter.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewPresenter {

    struct Properties {
        let fetchUser: Worker<Void?, [GithubUser]>
    }

    private let disposeBag = DisposeBag()

    // Model
    private var usersRelay = BehaviorRelay<[GithubUser]>(value: [])

    // ViewModels
    private var userViewModelsRelay = BehaviorRelay<[UserView.Model]>(value: [])

    private let properties: Properties
    init(properties: Properties) {
        self.properties = properties
        setupObserver()
    }

}

extension HomeViewPresenter {
    enum Component {
        static var `default`: HomeViewPresenter {
            return HomeViewPresenter(properties: .init(
                fetchUser: .just([
                    GithubUser(avatar: "", id: "1", name: "Nghia"),
                    GithubUser(avatar: "", id: "2", name: "Alexa")
                ])))
        }
    }
}
// MARK: - Actions
extension HomeViewPresenter: HomeViewAction {
    func viewDidLoad() {
        loadData()
    }
}

// MARK: - States
extension HomeViewPresenter: HomeViewState {
    var spentPerDayObservable: Observable<String> {
        return "100$".toObservable
    }

    var viewModelsObservable: Observable<[UserView.Model]> {
        return userViewModelsRelay.asObservable()
    }

    var userViewModels: [UserView.Model] {
        return userViewModelsRelay.value
    }

    private func setupObserver() {
        usersRelay.asObservable()
            .map { $0.map { UserView.Model(githubUser: $0) } }
            .bind(to: userViewModelsRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - Interactor
extension HomeViewPresenter {
    private func loadData() {
        properties.fetchUser.execute(payload: nil).bind(to: usersRelay).disposed(by: disposeBag)
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
