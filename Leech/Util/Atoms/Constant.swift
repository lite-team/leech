//
//  C.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/2/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

enum C { }

// MARK: - Metrics
extension C {
    enum Spacing {
        static var large: CGFloat { return 16 }
        static var medium: CGFloat { return 8 }
        static var small: CGFloat { return 4 }
        static var extraLarge: CGFloat { return 24 }
        static var huge: CGFloat { return 32 }
    }
}

// MARK: - Corner radiuses
extension C {
    enum CornerRadius {
        static var large: CGFloat { return 8 }
        static var medium: CGFloat { return 4 }
    }
}

// MARK: - Font Sizes
extension C {
    enum FontSize {
        static var extraHeading: CGFloat { return 48 }
        static var heading1: CGFloat { return 24 }
        static var heading2: CGFloat { return 20 }
        static var heading3: CGFloat { return 18 }
        static var subtitle: CGFloat { return 16 }
        static var body: CGFloat { return 14 }
        static var caption: CGFloat { return 12 }
    }
}

extension C {
    enum Border {
        static var width: CGFloat { return 0.5 }
        static var color: UIColor { return R.color.urbanGrey40() ?? .black }
    }
}

extension C {
    enum IconSize {
        static var xLarge: CGSize { return CGSize(width: 64, height: 64) }
        static var large: CGSize { return CGSize(width: 48, height: 48) }
        static var medium: CGSize { return CGSize(width: 36, height: 36) }
        static var small: CGSize { return CGSize(width: 24, height: 24) }
        static var tiny: CGSize { return CGSize(width: 16, height: 16) }
    }
}

extension C {
    enum Font {
        static var extraHeading: UIFont {
            return R.font.latoBold(size: C.FontSize.extraHeading)!
        }

        static var heading1: UIFont {
            return R.font.latoBold(size: C.FontSize.heading1)!
        }

        static var heading2: UIFont {
            return R.font.latoBold(size: C.FontSize.heading2)!
        }

        static var heading3: UIFont {
            return R.font.latoBold(size: C.FontSize.heading3)!
        }

        static var subtitle: UIFont {
            return R.font.latoRegular(size: C.FontSize.subtitle)!
        }

        static var body: UIFont {
            return R.font.latoRegular(size: C.FontSize.body)!
        }

        static var bodyCallout: UIFont {
            return R.font.latoBold(size: C.FontSize.body)!
        }

        static var caption: UIFont {
            return R.font.latoRegular(size: C.FontSize.caption)!
        }
    }
}


