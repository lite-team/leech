//
//  UserView.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/1/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

typealias UserView = TwoRowsInfoView

extension TwoRowsInfoView.Model {
    init(githubUser: GithubUser) {
        self.title = githubUser.name
        self.subtitle = githubUser.name
        self.placeholder = R.color.indigo60()
        self.isImageViewHidden = true
    }
}
