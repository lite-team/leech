//
//  HomeViewPresentable.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewAction {
    func viewDidLoad()
}

protocol HomeViewState {
    var spentPerDay: Observable<String> { get }
}

protocol HomeViewPresentable {
    var action: HomeViewAction { get }
    var state: HomeViewState { get }
}
