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

    // UIBuilder will use DSL syntax to layout programatically
    // We can add more UIView component and see the changes in real time.
    override var bodyView: UIView {
        HStackView(alignment: .center, spacing: C.Spacing.medium) {
            VStackView(spacing: C.Spacing.small) {
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
extension TwoRowsInfoView: ViewConfigurable {
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

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct TestView_Preview: PreviewProvider {
    
    // - create Preview struct conform with PreviewProvider in Debug mode only
    // - set up preview body is View converted from UIView through `.swiftUI` property
    // can update body to see the changes in real time.
    static var previews: some View {
        HStackView(alignment: .center, layoutMargins: UIEdgeInsets(horizontal: 10, vertical: 10)) {
            
            TwoRowsInfoView()
            .grab(viewModel:
                TwoRowsInfoView.Model(
                    title: "Nghia",
                    subtitle: "Nguyen",
                    placeholder: UIColor.blue.withAlphaComponent(0.5),
                    isImageViewHidden: false))
            
        }
        .swiftUI.previews(to: [.iphoneSE, .iphone11])
    }
}
#endif


