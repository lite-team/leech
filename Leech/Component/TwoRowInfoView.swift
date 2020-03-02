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
    struct Model: Equatable {
        let title: String?
        let subtitle: String?
        let placeholder: UIColor?
        let isImageViewHidden: Bool
    }
}

// MARK: - View
final class TwoRowsInfoView: BaseView {

    private let titleLabel: ParagraphLabel = ParagraphLabel().style().heading2
        .grab(numberOfLines: 0)

    private let subtitleLabel: ParagraphLabel = ParagraphLabel().style().subtitle
        .grab(numberOfLines: 0)

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
        self.titleLabel.paragraphText = viewModel.title
        self.subtitleLabel.paragraphText = viewModel.subtitle
        self.imageView.backgroundColor = viewModel.placeholder
        self.imageView.isHidden = viewModel.isImageViewHidden
    }
}

extension TwoRowsInfoView: LayoutModelTestable {
    static var layoutTestViewModels: [(String, TwoRowsInfoView.Model)] {
        [
            ("default", Model(
                title: "Title",
                subtitle: "Subtitle",
                placeholder: R.color.redDark60(),
                isImageViewHidden: false)),
            ("long title", Model(
                title: "Title super longgggggggggggggg adjfkasdjflajsfdlksajdlkf asdljflkasjdflajsdfljsaldf jlsadfj lasjdlf jsadlfj alsdfjl asdjflasjd lfjslkf jlkasdjf lkjlk",
                subtitle: "Subtitle",
                placeholder: R.color.redDark60(),
                isImageViewHidden: true))
        ]
    }
}

extension TwoRowsInfoView: CollectionViewCellWrappable {}
