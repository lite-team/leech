//
//  BaseView.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupView() {
        _ = bodyView
            .add(to: self)
            .configure {
                $0.snp.makeConstraints {
                    $0.top.leading.trailing.bottom.equalToSuperview()
                }
        }
    }

    public var bodyView: UIView {
        return UIView()
    }
}
