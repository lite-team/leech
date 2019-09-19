//
//  Coordinatable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol Coordinatable {
    func start(onFinish: (() -> Void)?)
}
