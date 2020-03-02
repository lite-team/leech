//
//  HomePresenterTests.swift
//  LeechTests
//
//  Created by Nghia Nguyen on 3/2/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import XCTest
import RxSwift
@testable import Leech

class HomePresenterTests: XCTestCase {

    private var disposeBag = DisposeBag()

    private enum WorkerError: Error {
        case cannotFetchUser
    }

    func testViewDidLoadSuccess() {
        let users = [GithubUser(avatar: "image", id: "2", name: "Nghia"),
                     GithubUser(avatar: "", id: "3", name: "Nghia")]
        let expectedViewModels = users.map { UserView.Model(githubUser: $0) }
        let props = HomeViewPresenter.Properties(fetchUser: Worker.just(users))
        let presenter: HomeViewPresentable = HomeViewPresenter(properties: props)

        var actualViewModels = [UserView.Model]()
        presenter.state.viewModelsDriver.asObservable().subscribe(onNext: { vms in
            actualViewModels = vms
        }).disposed(by: disposeBag)
        presenter.action.viewDidLoad()

        XCTAssertEqual(actualViewModels, expectedViewModels)
    }

    func testViewDidLoadFailure() {
        let expectedViewModels = [UserView.Model]()
        let props = HomeViewPresenter.Properties(fetchUser: Worker.error(WorkerError.cannotFetchUser))
        let presenter: HomeViewPresentable = HomeViewPresenter(properties: props)

        var actualViewModels = [UserView.Model]()
        presenter.state.viewModelsDriver
            .asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { vms in
            actualViewModels = vms
        }).disposed(by: disposeBag)
        presenter.action.viewDidLoad()

        XCTAssertEqual(actualViewModels, expectedViewModels)
    }
}
