//
//  UILabel.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/2/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

// MARK: - Attributes
public class ParagraphLabel: UILabel {

    private let paragraphStyle: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingTail
        return style
    }()

    public var kern: CGFloat? {
        didSet {
            build(text: attributedText)
        }
    }
}

// MARK: - Private functions
extension ParagraphLabel {
    private func build(text: NSAttributedString?) {
        guard let text = text else {
            attributedText = nil
            return
        }

        let range = NSRange(location: 0, length: text.string.count)
        let altText = NSMutableAttributedString(attributedString: text)
        var styles: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle]
        styles[.kern] = kern

        altText.setAttributes(styles, range: range)

        attributedText = altText
    }
}

// MARK: - Public functions
extension ParagraphLabel {

    public var paragraphText: String? {
        get {
            return self.text
        }

        set {
            build(text: newValue.map { NSAttributedString(string: $0) })
        }
    }

    public var paragraphAttributedText: NSAttributedString? {
        get {
            return self.attributedText
        }

        set {
            build(text: newValue)
        }
    }

    public var lineSpacing: CGFloat {
        set {
            paragraphStyle.lineSpacing = newValue
            build(text: attributedText)
        }

        get {
            return paragraphStyle.lineSpacing
        }
    }

    public var lineHeight: CGFloat {
        set {
            paragraphStyle.minimumLineHeight = newValue
            paragraphStyle.maximumLineHeight = newValue

            build(text: attributedText)
        }

        get {
            return paragraphStyle.minimumLineHeight
        }
    }


    public func configure(paragraphStyle configuration: (NSMutableParagraphStyle) -> Void) {
        configuration(paragraphStyle)
        build(text: attributedText)
    }
}
