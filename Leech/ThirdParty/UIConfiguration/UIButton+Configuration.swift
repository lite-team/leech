//
//  UIButton+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/18/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIButton {
    public func grab(title: String?, for state: UIControl.State = .normal) -> Self {
        self.setTitle(title, for: state)
        return self
    }

    public func grab(titleColor: UIColor?, for state: UIControl.State = .normal) -> Self {
        self.setTitleColor(titleColor, for: state)
        return self
    }

    public func grab(image: UIImage?, for state: UIControl.State = .normal) -> Self {
        self.setImage(image, for: state)
        return self
    }

    public func grab(backgroundImage: UIImage?, for state: UIControl.State = .normal) -> Self {
        self.setBackgroundImage(backgroundImage, for: state)
        return self
    }

    public func grab(contentEdgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = contentEdgeInsets
        return self
    }

    public func grab(target: Any?, action: Selector, for event: UIControl.Event
         = .touchUpInside) -> Self {
        addTarget(target, action: action, for: event)
        return self
    }

    public func grab(font: UIFont?) -> Self {
        titleLabel?.font = font
        return self
    }
}


