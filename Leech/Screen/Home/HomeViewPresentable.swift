//
//  HomeViewPresentable.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewAction {
    func viewDidLoad()
}

protocol HomeViewState {
    var spentPerDayDriver: Driver<String> { get }
    var viewModelsDriver: Driver<[UserView.Model]> { get }
    var userViewModels: [UserView.Model] { get }
}

protocol HomeViewPresentable {
    var action: HomeViewAction { get }
    var state: HomeViewState { get }
}
