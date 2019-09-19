//
//  ParagraphLabel+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/2/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension ParagraphLabel {
    public func grab(lineSpacing: CGFloat) -> Self {
        self.lineSpacing = lineSpacing
        return self
    }
}
