//
//  Workable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

public protocol Workable {
    associatedtype Payload
    associatedtype Output

    func execute(payload: Payload) -> Observable<Output>
}

