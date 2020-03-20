//
//  HomeViewController.swift
//  Leech
//
//  Created by Nghia Nguyen on 9/22/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Life cycle
final class HomeViewController: LeechViewController {

    private typealias Cell = CollectionViewCellWrapper<ContentInsetView<UserView, HVContentInset<MediumEdge, MediumEdge>>>

    private let presenter: HomeViewPresentable

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self)
        collectionView.style().configure {
            $0.backgroundColor = $1.backgroundColor
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    required init(presenter: HomeViewPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        isTransparent = true
        setupState()

        presenter.action.viewDidLoad()
    }

    override func setupView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.top.bottom.trailing.equalToSuperview()
        }
    }
}

// MARK: - Private functions
extension HomeViewController {
    private func setupState() {
        presenter.state
            .viewModelsDriver
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}

// MARK: - CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.state.userViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = presenter.state.userViewModels.getItem(at: indexPath.row) else { return UICollectionViewCell() }

        let cell: Cell = collectionView.dequeueReusableCell(for: indexPath)
        cell.wrapped.content.configure(viewModel: viewModel)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 80)
    }
}

// MARK: - Components
extension HomeViewController {
    enum Component {
        static var `default`: HomeViewController {
            return HomeViewController(presenter: HomeViewPresenter.Component.default)
        }
    }
}
