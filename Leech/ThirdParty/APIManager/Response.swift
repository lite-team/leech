//
//  Response.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/1/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation

public struct Response<T> {
    public let result: Result<T, Error>
    public let urlResponse: URLResponse?
}
