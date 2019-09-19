//
//  UIView+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/19/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIView.Style where T: UIView {
    var shadow: T {
        view
            .grab(shadowColor: .black)
            .grab(shadowOffset: CGSize(width: 0, height: 1))
            .grab(shadowRadius: 4)
            .grab(shadowOpacity: 0.25)
    }
}
