//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit

/*
 LayoutModelTestable defines structure for class which want to test
 with multiple view models
 */
public protocol LayoutModelTestable: LayoutInstanceTestable {
    associatedtype LayoutTestViewModel

    // Array of view models need be tested enclosed description.
    static var layoutTestViewModels: [(String, LayoutTestViewModel)] { get }
    func configure(viewModel: LayoutTestViewModel)
}

extension LayoutModelTestable where Self: UIView {
    public static var testContentViewController: UIViewController {
        return LayoutModelTestingViewController<Self>()
    }
}
