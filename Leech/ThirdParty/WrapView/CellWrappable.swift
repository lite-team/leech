//
//  CellWrappable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit


public protocol ViewReusable {
    func prepareForReuse()
}

extension ViewReusable {
    public func prepareForReuse() {}
}
