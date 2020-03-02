//
//  Reusable.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/2/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import UIKit

public protocol Resuable {
    static var identifier: String { get }
}

extension Resuable {
    public static var identifier: String {
        return String(describing: self)
    }
}


