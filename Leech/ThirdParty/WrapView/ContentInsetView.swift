//
//  ContentInsetView.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public protocol Edgeable {
    static var edge: CGFloat { get }
}

public protocol Insetable {
    static var insets: UIEdgeInsets { get }
}

public class ContentInsetView<V: UIView, I: Insetable>: UIView {
    public let content: V

    public override init(frame: CGRect) {
        content = V()
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(content)

        let insets = I.insets

        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor
            .constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom).isActive = true
    }
}

extension ContentInsetView: CollectionViewCellWrappable {}

public class ContentInset<Top: Edgeable, Left: Edgeable, Bottom: Edgeable, Right: Edgeable>: Insetable {
    public static var insets: UIEdgeInsets {
        return UIEdgeInsets(
            top: Top.edge,
            left: Left.edge,
            bottom: Bottom.edge,
            right: Right.edge)
    }
}

public class HVContentInset<Horizontal: Edgeable, Vertical: Edgeable>: ContentInset<Vertical, Horizontal, Vertical, Horizontal> {}

public class TopContentInset<Top: Edgeable>: ContentInset<Top, EmptyEdge, EmptyEdge, EmptyEdge> {}

public class LeftContentInset<Left: Edgeable>: ContentInset<EmptyEdge, Left, EmptyEdge, EmptyEdge> {}

public class RightContentInset<Right: Edgeable>: ContentInset<EmptyEdge, EmptyEdge, EmptyEdge, Right> {}

public class BottomContentInset<Bottom: Edgeable>: ContentInset<EmptyEdge, EmptyEdge, Bottom, EmptyEdge> {}

public struct EmptyEdge: Edgeable {
    public static var edge: CGFloat { return 0 }
}
