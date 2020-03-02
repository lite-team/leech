//
//  UICollectionView+Reusable.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/2/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell & Resuable>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: T.identifier)
    }

    public func dequeueReusableCell<T: UICollectionViewCell & Resuable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}


