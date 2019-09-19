//
//  Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/19/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    struct Style<T: UIView> {
        let theme: Themeable
        let view: T
    }
}

protocol ViewStyable {}

extension ViewStyable where Self: UIView {
    func style(theme: Themeable = DefaultTheme.shared) -> UIView.Style<Self> {
        return Style(theme: theme, view: self)
    }
}

extension UIView: ViewStyable {}
