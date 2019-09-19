//
//  RxSwift+Extension.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    public enum GeneralError: Error {
        case badAccess
    }

    public func weakSubscribe<P: AnyObject>(
        _ target: P,
        onNext: ((P, Element) -> Void)? = nil,
        onError: ((P, Error) -> Void)? = nil,
        onCompleted: ((P) -> Void)? = nil,
        onDisposed: ((P) -> Void)? = nil) -> Disposable {

        return self.subscribe(
            onNext: { [weak target] element in
                guard let target = target else { return }
                onNext?(target, element)

            },
            onError: { [weak target] error in
                guard let target = target else { return }
                onError?(target, error)
            },
            onCompleted: { [weak target] in
                guard let target = target else { return }
                onCompleted?(target)
            },
            onDisposed: { [weak target] in
                guard let target = target else { return }
                onDisposed?(target)
        })
    }

    public func weakFlatMapLatest<P: AnyObject, O>(_ target: P, selector: @escaping (P, Element) -> Observable<O>) -> Observable<O> {
        return self.flatMapLatest { [weak target] (element) -> Observable<O> in
            guard let target = target else {
                return Observable<O>.error(GeneralError.badAccess) }
            return selector(target, element)
        }
    }
}
