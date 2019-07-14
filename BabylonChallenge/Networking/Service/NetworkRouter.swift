//
//  NetworkRouter.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import Foundation

protocol NetworkRouter: class {
    func request<T: Decodable>(type: T.Type, from endPoint: EndPoint, completion: @escaping ((Result<[T], Error>) -> Void))
    func cancel()
}

// MARK: - Reactive
extension NetworkRouter {
    
    /**
     
     I generally prefer wrapping APIs with Rx extensions for two reasons
     - It saves me the time of reimplementing the apis if I decide to make changes. e.g. RxSwift -> Apple Combine/ReactiveCocoa
     - I also recognise that not everyone may be comfortable with reactive programming and having the normal APIs offers an alternative
     
     */
    func request<T: Decodable>(type: T.Type, from endPoint: EndPoint) -> Single<[T]> {
        return .create(subscribe: { (single) -> Disposable in
            self.request(type: type, from: endPoint, completion: { (result) in
                switch result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    single(.error(error))
                }
            })
            return Disposables.create()
        })
    }
    
}

