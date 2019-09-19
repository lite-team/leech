//
//  Worker.swift
//  Leech
//
//  Created by Nghia Nguyen on 8/24/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

public class Worker<P, O>: Workable {
    public typealias Payload = P
    public typealias Output = O

    private let executor: (P) -> Observable<O>

    required public init(_ executor: @escaping (P) -> Observable<O>) {
        self.executor = executor
    }

    public func execute(payload: P) -> Observable<O> {
        return executor(payload)
    }
}

extension Worker {
    static func just(_ output: O) -> Worker<P, O> {
        return Worker<P, O>({ _ in return Observable.just(output) })
    }

    static func error(_ error: Error) -> Worker<P, O> {
        return Worker<P, O>({ _ in return Observable.error(error) })
    }
}
