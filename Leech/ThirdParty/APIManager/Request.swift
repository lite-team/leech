//
//  Request.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/1/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import UIKit

public enum Parameter {
    case urlEncoded([String: CustomStringConvertible]?)
    case body([String: Any]?)

    var body: [String: Any]? {
        switch self {
        case let .body(data):
            return data
        default: return nil
        }
    }
}

public enum Method: String {
    case GET, POST, PUT, DELETE, PATCH
}

public struct Request {
    let path: String
    let method: Method
    let parameters: Parameter?
    let headers: [String: String]?
    let timeoutInterval: TimeInterval?
}

extension Request {
    public func requestURL(scheme: String, host: String, defaultHeaders: [String: String]?) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        switch parameters {
        case let .urlEncoded(params):
            urlComponents.queryItems = params?.map({ URLQueryItem(name: $0.key, value: $0.value.description) }) ?? []
        default:
            break
        }
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = parameters?.body.flatMap {
            try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
        urlRequest.allHTTPHeaderFields = headers.flatMap {
            defaultHeaders?.merging($0, uniquingKeysWith: {(_, new) in return new }) }
        if let timeoutInterval = self.timeoutInterval {
            urlRequest.timeoutInterval = timeoutInterval
        }
        return urlRequest
    }
}
