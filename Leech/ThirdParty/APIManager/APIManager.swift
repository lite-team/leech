//
//  APIManager.swift
//  Leech
//
//  Created by Nghia Nguyen on 3/1/20.
//  Copyright © 2020 Nghia Nguyen. All rights reserved.
//

import Foundation
import RxSwift

public typealias ResponseType<T> = (Response<T>) -> Void

public class APIManager {

    public enum GeneralError: Error {
        case dataEmpty
        case parseFailure
    }

    public struct Configuration {

    }

    public let scheme: String
    public let host: String
    public let configuration: Configuration
    public private(set) var defaultHeaders = [String: String]()

    private let urlSession: URLSession

    public init(
        scheme: String = "https",
        host: String,
        configuration: Configuration,
        urlSession: URLSession = URLSession.shared) {
        self.scheme = scheme
        self.host = host
        self.configuration = configuration
        self.urlSession = urlSession
    }
}

// MARK: - Public functions
extension APIManager {
    public func setDefaultHeaders(_ headers: [String: String]) {
        self.defaultHeaders.merge(headers) { (_, new) -> String in
            return new
        }
    }

    public func request(_ req: Request, completion: ResponseType<Data?>?) -> URLSessionDataTask? {
        guard let urlRequest = convertToURLRequest(from: req) else { return nil }

        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let error = error {
                completion?(Response(result: .failure(error), urlResponse: urlResponse))
            } else {
                completion?(Response(result: .success(data), urlResponse: urlResponse))
            }
        }
        task.resume()
        return task
    }

    public func request<T>(
        _ req: Request,
        mapping: @escaping (Data) -> T?,
        completion: ResponseType<T>?) -> URLSessionDataTask? {
        return request(req) { (response) in
            switch response.result {
            case let .success(data):
                guard let data = data else {
                    completion?(Response(
                        result: .failure(GeneralError.dataEmpty),
                        urlResponse: response.urlResponse))
                    return
                }

                guard let value = mapping(data) else {
                    completion?(Response(result: .failure(GeneralError.parseFailure),
                                         urlResponse: response.urlResponse))
                    return
                }

                completion?(Response(result: .success(value), urlResponse: response.urlResponse))
            case let .failure(error):
                completion?(Response(result: .failure(error), urlResponse: response.urlResponse))
            }
        }
    }

    public func request<T: Decodable>(_ req: Request) -> Observable<T> {
        return Observable.create {[weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create {} }
            let task = self.request(req, mapping: { (data) -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
            }) { (response) in
                switch response.result {
                case let .success(value):
                    observer.onNext(value)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                task?.cancel()
            }
        }
    }

    public func request<T: Decodable>(_ req: Request) -> Observable<[T]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create {} }
            let task = self.request(req, mapping: { (data) -> [T] in
                return (try? JSONDecoder().decode([T].self, from: data)) ?? []
            }) { (response) in
                switch response.result {
                case let .success(value):
                    observer.onNext(value)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

// MARK: - Private functions
extension APIManager {
    private func convertToURLRequest(from request: Request) -> URLRequest? {
        request.requestURL(scheme: scheme, host: host, defaultHeaders: defaultHeaders)
    }
}
