//
//  ViewBuilder.swift
//  LiteUIBuilder
//
//  Created by Nghia Nguyen on 8/15/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

@_functionBuilder
public struct ViewBuilder {
    static func buildBlock(_ views: UIView...) {}
}

public protocol ViewBuildable {}

extension UIView: ViewBuildable {}

extension ViewBuildable where Self: UIView {
    public func configure(closure: (Self) -> Void) -> Self  {
        closure(self)
        return self
    }

    public func add(to superview: UIView) -> Self {
        superview.addSubview(self)
        return self
    }

    public func build(@ViewBuilder builder: (Self) -> Void) -> Self {
        builder(self)
        return self
    }
}
