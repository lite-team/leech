//
//  StackViewBuilder.swift
//  LiteUIBuilder
//
//  Created by Nghia Nguyen on 8/15/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

@_functionBuilder
public struct StackViewBuilder {
    public static func buildBlock(_ views: UIView...) -> [UIView] {
        return views
    }

    public static func buildBlock(_ view: UIView) -> UIView {
        return view
    }
}

public class VStackView: StackView {
    public required init(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0,
        layoutMargins: UIEdgeInsets = .zero,
        @StackViewBuilder builder: () -> [UIView]) {
        super.init(
            axis: .vertical,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            layoutMargins: layoutMargins,
            arrangedSubviews: builder())
    }

    public required init(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0,
        layoutMargins: UIEdgeInsets = .zero,
        @StackViewBuilder builder: () -> UIView) {
        super.init(
            axis: .vertical,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            layoutMargins: layoutMargins,
            arrangedSubviews: [builder()])
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class HStackView: StackView {
    public required init(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0,
        layoutMargins: UIEdgeInsets = .zero,
        @StackViewBuilder builder: () -> [UIView]) {
        super.init(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            layoutMargins: layoutMargins,
            arrangedSubviews: builder())
    }

    public required init(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0,
        layoutMargins: UIEdgeInsets = .zero,
        @StackViewBuilder builder: () -> UIView) {
        super.init(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            layoutMargins: layoutMargins,
            arrangedSubviews: [builder()])
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class StackView: UIStackView {

    public init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat,
        layoutMargins: UIEdgeInsets,
        arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = layoutMargins
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
