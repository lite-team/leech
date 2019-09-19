//
//  CollectionReusableViewWrappable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public protocol CollectionReusableViewWrappable: ViewReusable {
    func attach(to view: UICollectionReusableView)
    func didAttach(to view: UICollectionReusableView)
}

extension CollectionReusableViewWrappable where Self: UIView {
    public func attach(to view: UICollectionReusableView) {
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    public func didAttach(to view: UICollectionReusableView) {}
}

public class CollectionReusableViewWrapper<T: CollectionReusableViewWrappable & UIView>: UICollectionReusableView {

    public let wrapped: T

    public override init(frame: CGRect) {
        wrapped = T()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        wrapped.attach(to: self)
        wrapped.didAttach(to: self)
    }

    public override func prepareForReuse() {
        wrapped.prepareForReuse()
    }
}
