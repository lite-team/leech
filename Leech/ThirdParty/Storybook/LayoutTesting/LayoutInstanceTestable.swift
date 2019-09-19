//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit

/*
 Define view controller type test view controller
 Support 2 types SINGLE and NAVIGATION_BAR
 */
public enum LayoutTestType {
    case single
    case navigationBar
}

/*
 LayoutTestConstraint defines to setup constraint for testing instance in view controller
 .auto: Auto sizing dimension with intrinsic size
 .constant: Set constraint with implict constant
 .relative(multiple, constant): Set constraint with parent view
 */
public enum LayoutTestConstraint {
    case auto
    case constant(value: CGFloat)
    case relative(multiple: CGFloat, constant: CGFloat)

    public static var relativeEqual: LayoutTestConstraint {
        return .relative(multiple: 1, constant: 0)
    }
}

/*
 LayoutTestSize defines width and height constraint for testing instance
 */
public struct LayoutTestSize {
    let width: LayoutTestConstraint
    let height: LayoutTestConstraint

    public init(width: LayoutTestConstraint, height: LayoutTestConstraint) {
        self.width = width
        self.height = height
    }

    static var `auto`: LayoutTestSize { return LayoutTestSize(width: .auto, height: .auto) }
}

/*
 LayoutInstanceTestable is convience protocol providing structure
 to setup testViewConntroller attribute with LayoutTestingViewController
 */
public protocol LayoutInstanceTestable: LayoutTestable {
    // The instance to test, default it will call init() function to create new one
    static var testInstance: Any { get }

    // Default is .navigationBar
    static var testType: LayoutTestType { get }

    // Default is .relativeEqual width and .auto height
    static var testSize: LayoutTestSize { get }

    // The view controller concludes test instance
    // Default is LayoutTestingViewController instance
    static var testContentViewController: UIViewController { get }

    // Configure test instance. Default is empty
    func configureTesting()
}

extension LayoutInstanceTestable {
    public static var testType: LayoutTestType { return .navigationBar }

    public static var testViewController: UIViewController {
        let vc = testContentViewController
        let type = testType
        switch type {
        case .navigationBar:
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.navigationBar.isTranslucent = false
            return navigationController
        case .single:
            return vc
        }
    }

    public static var testContentViewController: UIViewController {
        return LayoutTestingViewController<Self>()
    }

    public func configureTesting() { }
}

extension LayoutInstanceTestable where Self: UIView {
    public static var testInstance: Any { return self.init(frame: .zero) }
    public static var testSize: LayoutTestSize {
        return LayoutTestSize(width: .relativeEqual, height: .auto) }
}

extension LayoutInstanceTestable where Self: UIViewController {
    public static var testSize: LayoutTestSize { return .auto }
    public static var testInstance: Any { return self.init() }
}
