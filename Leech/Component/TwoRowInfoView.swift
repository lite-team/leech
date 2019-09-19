//
//  TwoRowInfoView.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/2/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Model
extension TwoRowsInfoView {
    struct Model {
        let title: String?
        let subtitle: String?
        let placeholder: UIColor?
        let isImageViewHidden: Bool
    }
}

// MARK: - View
final class TwoRowsInfoView: BaseView {

    private let titleLabel = ParagraphLabel().style().heading2
    private let subtitleLabel = ParagraphLabel().style().subtitle

    private let imageView = UIImageView()
        .grab(masksToBounds: true)
        .grab(cornerRadius: C.CornerRadius.large)
        .grab(backgroundColor: R.color.urbanGrey40())
        .configure {
            $0.snp.makeConstraints {
                $0.size.equalTo(C.IconSize.xLarge)
            }
    }

    override var bodyView: UIView {
        HStackView(alignment: .center, spacing: C.Spacing.medium) {
            VStackView {
                self.titleLabel
                self.subtitleLabel
            }
            self.imageView
        }
    }

    override func setupView() {
        _ = self.grabSubview(bodyView) {
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview().inset(
                    UIEdgeInsets(horizontal: C.Spacing.medium, vertical: C.Spacing.medium))
            }
            }
            .style().shadow
            .grab(cornerRadius: C.CornerRadius.large)
            .grab(backgroundColor: .white)
    }
}

// MARK: - Public functions
extension TwoRowsInfoView {
    func configure(viewModel: Model) {
        self.titleLabel.text = viewModel.title
        self.subtitleLabel.text = viewModel.subtitle
        self.imageView.backgroundColor = viewModel.placeholder
        self.imageView.isHidden = viewModel.isImageViewHidden
    }
}

// MARK: - Concret types
extension TwoRowsInfoView {
    typealias NotificationCard = TwoRowsInfoView
}

extension TwoRowsInfoView: LayoutModelTestable {
    static var layoutTestViewModels: [(String, TwoRowsInfoView.Model)] {
        [
            ("default", Model(
                title: "Title",
                subtitle: "Subtitle",
                placeholder: R.color.indigoLight60(),
                isImageViewHidden: false))
        ]
    }
}
