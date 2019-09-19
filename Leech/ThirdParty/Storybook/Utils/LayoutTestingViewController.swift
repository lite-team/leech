//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit

/*
 DeviceType defines dimensions screen which support to testing
 */
private enum DeviceType: String, CaseIterable {
    case iphone5s = "Iphone 5s"
    case iphone6 = "Iphone 6" // plus is same
    case iphone6plus = "Iphone 6 plus"
    case iphoneX = "Iphone X"
    case iphoneXR = "Iphone XR" // xmax is same

    var size: CGSize {
        switch self {
        case .iphone5s:
            return CGSize(width: 320, height: 568)
        case .iphone6:
            return CGSize(width: 375, height: 667)
        case .iphone6plus:
            return CGSize(width: 414, height: 736)
        case .iphoneX:
            return CGSize(width: 375, height: 812)
        case .iphoneXR:
            return CGSize(width: 414, height: 896)
        }
    }

    var topBar: CGFloat {
        switch self {
        case .iphone5s, .iphone6, .iphone6plus:
            return 64
        case .iphoneX, .iphoneXR:
            return 88
        }
    }

    static func getType(withSize size: CGSize) -> DeviceType? {
        let types = self.allCases
        for type in types {
            if type.size.width == size.width
                && type.size.height == size.height {
                return type
            }
        }

        return nil
    }

    var next: DeviceType? {
        let types = DeviceType.allCases
        guard let index = types.lastIndex(where: { $0 == self }) else { return nil }
        return types[(index + 1) % types.count]
    }
}

/*
 LayoutTestingViewController create a testing view controller
 which support testing for multiple dimensions
 */
class LayoutTestingViewController<T: LayoutInstanceTestable>: UIViewController {

    let instance: T? = T.testInstance as? T

    private var currentDeviceType = DeviceType.getType(withSize: UIScreen.main.bounds.size) {
        didSet {
            setupDevice()
        }
    }

    private lazy var childViewController: UIViewController = {
        let childViewController: UIViewController
        switch instance {
        case let subViewController as UIViewController:
            childViewController = subViewController
        case let subView as UIView:
            childViewController = UIViewController()
            childViewController.view.addSubview(subView)

            subView.translatesAutoresizingMaskIntoConstraints = false
            let subViewSize = T.testSize
            switch subViewSize.height {
            case .auto:
                break
            case .constant(let value):
                subView.heightAnchor.constraint(equalToConstant: value).isActive = true
            case .relative(let multiple, let constant):
                subView.heightAnchor.constraint(
                    equalTo: childViewController.view.heightAnchor,
                    multiplier: multiple,
                    constant: constant).isActive = true
            }

            switch subViewSize.width {
            case .auto:
                break
            case .constant(let value):
                subView.widthAnchor.constraint(equalToConstant: value).isActive = true
            case .relative(let multiple, let constant):
                subView.widthAnchor.constraint(
                    equalTo: childViewController.view.widthAnchor,
                    multiplier: multiple,
                    constant: constant).isActive = true
            }

        default:
            childViewController = UIViewController()
        }

        return childViewController
    }()

    private lazy var bottomContainerView: UIView = {
        let view = UIView()
        let panGesture = UIPanGestureRecognizer(
            target: self, action: #selector(didSwipeBottomView(_:)))
        view.addGestureRecognizer(panGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()

    private let sizeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(didTapSizeButton), for: .touchUpInside)
        return button
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    private lazy var scrollingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Scrolling", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(didTapScrollingButton), for: .touchUpInside)
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    private lazy var sizeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [sizeButton, scrollingButton, closeButton])
        view.spacing = 8
        return view
    }()

    private(set) lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sizeStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private var isSetupLayout = false

    private var childViewHeightConstraint: NSLayoutConstraint?
    private var childViewWidthConstraint: NSLayoutConstraint?
    private var bottomContainerViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !isSetupLayout {
            setupViews()
        }
    }

    func setupViews() {
        isSetupLayout = true

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor)
            ])


        if let childView = childViewController.view {
            childView.translatesAutoresizingMaskIntoConstraints = false
            addChild(childViewController)
            scrollView.addSubview(childView)
            NSLayoutConstraint.activate([
                childView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                childView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                childView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                childView.topAnchor.constraint(equalTo: scrollView.topAnchor)
                ])
            childViewHeightConstraint = childView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            childViewHeightConstraint?.isActive = true
            childViewWidthConstraint = childView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
            childViewWidthConstraint?.isActive = true

            childView.layer.borderWidth = 1
            childView.layer.borderColor = UIColor.gray.cgColor
            childViewController.didMove(toParent: self)

            instance?.configureTesting()
        }

        view.addSubview(bottomContainerView)
        NSLayoutConstraint.activate([
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        bottomContainerViewBottomConstraint = bottomContainerView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: -16)
        bottomContainerViewBottomConstraint?.isActive = true

        bottomContainerView.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(
                equalTo: bottomContainerView.leadingAnchor, constant: 8),
            bottomStackView.trailingAnchor.constraint(
                equalTo: bottomContainerView.trailingAnchor, constant: -8),
            bottomStackView.bottomAnchor.constraint(
                equalTo: bottomContainerView.bottomAnchor, constant: -8),
            bottomStackView.topAnchor.constraint(
                equalTo: bottomContainerView.topAnchor, constant: 8)
            ])

        if presentingViewController != nil {
            closeButton.isHidden = false
        }

        setupDevice()
    }

    @objc private func didTapSizeButton() {
        guard let nextDeviceType = currentDeviceType?.next else {
            return
        }
        currentDeviceType = nextDeviceType
    }

    @objc private func didTapScrollingButton() {
        scrollView.isScrollEnabled.toggle()
        let color: UIColor = scrollView.isScrollEnabled ? .black : .white
        scrollingButton.setTitleColor(color, for: .normal)
        scrollingButton.layer.borderColor = color.cgColor
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }

    private var startPoint: CGPoint?
    @objc private func didSwipeBottomView(_ panGesture: UIPanGestureRecognizer) {
        let point = panGesture.translation(in: bottomContainerView.superview)
        switch panGesture.state {
        case .began:
            startPoint = point
        default:
            let delta = point.y - (startPoint?.y ?? 0)
            startPoint = point
            bottomContainerViewBottomConstraint?.constant += delta
            bottomContainerView.superview?.layoutIfNeeded()
        }
    }

    private func setupDevice() {
        guard let deviceType = currentDeviceType else {
            return
        }

        let hasNavigationBar = navigationController?.navigationBar.isHidden == false

        let size = CGSize(
            width: deviceType.size.width,
            height: deviceType.size.height - (hasNavigationBar ? deviceType.topBar : 0))
        childViewWidthConstraint?.constant = size.width
        childViewHeightConstraint?.constant = size.height
        childViewController.view.superview?.layoutIfNeeded()

        sizeButton.setTitle(deviceType.rawValue, for: .normal)
    }
}
