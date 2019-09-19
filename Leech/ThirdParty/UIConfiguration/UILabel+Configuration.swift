//
//  UILabel+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/18/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UILabel {
    public func grab(text: String?) -> Self {
        self.text = text
        return self
    }

    public func grab(textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }

    public func grab(numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

    public func grab(textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    public func grab(font: UIFont?) -> Self {
        self.font = font
        return self
    }
}
