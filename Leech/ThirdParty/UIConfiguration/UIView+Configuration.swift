//
//  UIView+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/18/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    public func grab(backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    public func grab(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        return self
    }

    public func grab(borderWidth: CGFloat) -> Self {
        self.layer.borderWidth = borderWidth
        return self
    }

    public func grab(borderColor: UIColor?) -> Self {
        self.layer.borderColor = borderColor?.cgColor
        return self
    }

    public func grab(shadowColor: UIColor?) -> Self {
        self.layer.shadowColor = shadowColor?.cgColor
        return self
    }

    public func grab(shadowRadius: CGFloat) -> Self {
        self.layer.shadowRadius = shadowRadius
        return self
    }

    public func grab(shadowOpacity: Float) -> Self {
        self.layer.shadowOpacity = shadowOpacity
        return self
    }

    public func grab(shadowOffset: CGSize) -> Self {
        self.layer.shadowOffset = shadowOffset
        return self
    }

    public func grab(masksToBounds: Bool) -> Self {
        self.layer.masksToBounds = masksToBounds
        return self
    }

    public func grabSubview<T: UIView>(_ subview: T, configuration: ((T) -> Void)?) -> Self {
        self.addSubview(subview)
        configuration?(subview)
        return self
    }
}
