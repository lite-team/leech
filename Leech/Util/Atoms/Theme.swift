//
//  Theme.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/2/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

protocol Themeable: class {
    var textColor: UIColor { get }
    var invertTextColor: UIColor { get }

    var backgroundColor: UIColor { get }

    var primaryColor: UIColor { get }

    var secondaryColor: UIColor { get }
}


final class DefaultTheme: Themeable {

    static let shared = DefaultTheme()

    var textColor: UIColor { return R.color.urbanGrey60() ?? .black }

    var invertTextColor: UIColor { return .white }

    var backgroundColor: UIColor { return .white }

    var primaryColor: UIColor { return R.color.indigo60() ?? .black }

    var secondaryColor: UIColor { return R.color.red60() ?? .black }
}

var appTheme: Themeable = DefaultTheme.shared
