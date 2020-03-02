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
    var spentPerDayDriver: Driver<String> {
        return Driver.just("100$")
    }

    var viewModelsDriver: Driver<[UserView.Model]> {
        return userViewModelsRelay.asDriver()
    }

    var userViewModels: [UserView.Model] {
        return userViewModelsRelay.value
    }

    private func setupObserver() {
        usersRelay.asDriver()
            .map { $0.map { UserView.Model(githubUser: $0) } }
            .drive(userViewModelsRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - Interactor
extension HomeViewPresenter {
    private func loadData() {
        properties.fetchUser
            .execute(payload: nil)
            .asDriver(onErrorJustReturn: usersRelay.value)
            .drive(usersRelay)
            .disposed(by: disposeBag)
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
