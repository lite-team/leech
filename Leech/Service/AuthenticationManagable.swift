//
//  AuthenticationManagable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit
import RxSwift

final class AuthenticationManager {
    static let shared = AuthenticationManager()

    private init() {}

    var isAuthenticated: Bool {
        return true
    }
}
