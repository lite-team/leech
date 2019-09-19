//
//  Copyright © 2019 Carousell. All rights reserved.
//

import UIKit


/*
 LayoutModelTestingViewController provides function and UI to switch between view models
 to test compatibility with layout.
 */
final class LayoutModelTestingViewController<T: LayoutModelTestable>: LayoutTestingViewController<T> {
    let viewModels = T.layoutTestViewModels
    private var currentIndex = 0 {
        didSet {
            setupViewModel()
        }
    }

    private var currentViewModel: (String,T.LayoutTestViewModel)? {
        guard 0...viewModels.count - 1 ~= currentIndex else { return nil }
        return viewModels[currentIndex]
    }

    private lazy var viewModelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapViewModelButton), for: .touchUpInside)
        return button
    }()

    override func setupViews() {
        super.setupViews()

        bottomStackView.addArrangedSubview(viewModelButton)

        setupViewModel()
    }

    @objc private func didTapViewModelButton() {
        guard viewModels.count > 0 else { return }
        currentIndex = (currentIndex + 1) % viewModels.count
    }

    private func setupViewModel() {
        currentViewModel.map { instance?.configure(viewModel: $0.1) }
        viewModelButton.setTitle(currentViewModel?.0, for: .normal)
    }
}
