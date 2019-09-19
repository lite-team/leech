//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc
    var topMostViewController: UIViewController {
        var presented: UIViewController? = self

        while let next = presented?.stackedViewController {
            presented = next
        }

        return presented ?? self
    }

    private var stackedViewController: UIViewController? {
        return
            (self as? UITabBarController)?.selectedViewController ??
                (self as? UINavigationController)?.visibleViewController ??
        presentedViewController
    }

}
