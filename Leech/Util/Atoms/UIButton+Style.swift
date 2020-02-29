//
//  UIButton+Style.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/19/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UIView.Style where T: UIButton {

    enum Size {
        case large
        case medium

        var height: CGFloat {
            switch self {
            case .large:
                return 48
            case .medium:
                return 36
            }
        }

        var font: UIFont {
            switch self {
            case .large:
                return C.Font.heading3
            case .medium:
                return C.Font.bodyCallout
            }
        }
    }

    func primary(size: Size) -> T {
        return view
            .grab(masksToBounds: true)
            .grab(backgroundImage: UIImage(color: theme.primaryColor), for: .normal)
            .grab(backgroundImage: UIImage(color: theme.primaryColor.withAlphaComponent(0.6)), for: .highlighted)
            .grab(cornerRadius: C.CornerRadius.large)
            .grab(contentEdgeInsets: UIEdgeInsets(
                horizontal: C.Spacing.large, vertical: 0))
            .grab(font: size.font)
            .grab(titleColor: theme.invertTextColor, for: .normal)
            .configure(closure: {
                $0.snp.makeConstraints {
                    $0.height.equalTo(size.height)
                }
            })
    }

    func secondary(size: Size) -> T {
        return view
            .grab(masksToBounds: true)
            .grab(borderColor: C.Border.color)
            .grab(borderWidth: C.Border.width)
            .grab(cornerRadius: C.CornerRadius.large)
            .grab(contentEdgeInsets: UIEdgeInsets(
                horizontal: C.Spacing.large, vertical: 0))
            .grab(font: size.font)
            .grab(titleColor: theme.textColor, for: .normal)
            .configure {
                $0.snp.makeConstraints {
                    $0.height.equalTo(size.height)
                }
        }
    }

    func text(size: Size) -> T {
        return view
            .grab(masksToBounds: true)
            .grab(font: size.font)
            .grab(titleColor: theme.primaryColor, for: .normal)
    }
}
