//
//  UIImageView.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/18/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIImageView {
    public func grab(image: UIImage?) -> Self {
        self.image = image
        return self
    }

    public func grab(contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
}
