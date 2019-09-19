//
//  CollectionViewCellWrappable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/25/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public protocol CollectionViewCellWrappable: ViewReusable {
    func attach(to cell: UICollectionViewCell)
    func didAttach(to cell: UICollectionViewCell)
}

extension CollectionViewCellWrappable where Self: UIView {
    public func attach(to cell: UICollectionViewCell) {
        let contentView = cell.contentView

        contentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    public func didAttach(to cell: UICollectionViewCell) {}
}

public class CollectionViewCellWrapper<T: UIView & CollectionViewCellWrappable>: UICollectionViewCell {

    public let wrapped: T

    public override init(frame: CGRect) {
        wrapped = T()
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        wrapped.attach(to: self)
        wrapped.didAttach(to: self)
    }

    public override func prepareForReuse() {
        wrapped.prepareForReuse()
    }
}
