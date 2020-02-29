//
//  ParagraphLabel+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/18/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIView.Style where T: ParagraphLabel {
    var heading1: T {
        return view
            .grab(font: C.Font.heading1)
            .grab(lineHeight: 29)
            .grab(textColor: theme.textColor)
    }

    var heading2: T {
        return view
            .grab(font: C.Font.heading2)
            .grab(lineHeight: 24)
            .grab(lineSpacing: 4)
            .grab(textColor: theme.textColor)
    }

    var heading3: T {
        return view
            .grab(font: C.Font.heading3)
            .grab(lineHeight: 22)
            .grab(textColor: theme.textColor)
    }

    var subtitle: T {
        return view
            .grab(font: C.Font.subtitle)
            .grab(lineHeight: 19)
            .grab(textColor: theme.textColor)
    }

    var body: T {
        return view
            .grab(font: C.Font.body)
            .grab(lineHeight: 17)
            .grab(textColor: theme.textColor)
    }

    var bodyCallout: T {
        return view
            .grab(font: C.Font.bodyCallout)
            .grab(lineHeight: 17)
            .grab(textColor: theme.textColor)
    }

    var caption: T {
        return view
            .grab(font: C.Font.caption)
            .grab(lineHeight: 14)
            .grab(textColor: theme.textColor)
    }

}
