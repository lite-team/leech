//
//  RxSwift+RawObservable.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

public protocol ToObservable {
    var toObservable: Observable<Self> { get }
}

extension ToObservable {
    public var toObservable: Observable<Self> {
        return Observable.just(self)
    }
}

extension Int: ToObservable {}
extension Double: ToObservable {}
extension String: ToObservable {}
extension Bool: ToObservable {}

extension Error {
    public func toObservable<T>() -> Observable<T> {
        return Observable.error(self)
    }
}
