//
//  Copyright © 2019 Nghia. All rights reserved.
//

import UIKit

public protocol SwiftUIAdaptable {}

extension SwiftUIAdaptable where Self: UIView {
    @available(iOS 13.0, *)
    public var swiftUI: SwiftUIView<Self> {
        SwiftUIView(view: self)
    }
}

extension SwiftUIAdaptable where Self: ViewConfigurable {
    func grab(viewModel: Model) -> Self {
        configure(viewModel: viewModel)
        return self
    }
}

extension UIView: SwiftUIAdaptable {}
