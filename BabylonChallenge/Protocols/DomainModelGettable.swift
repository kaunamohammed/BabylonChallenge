//
//  DomainModelGettable.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 17/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift

protocol DomainModelGettable {
    func getModels<T: Decodable>(endPoint: EndPoint, convertTo type: T.Type, completion: @escaping (Result<[T], NetworkError>) -> Void)
}

extension DomainModelGettable {
    func rx_getModels<T: Decodable>(from endPoint: EndPoint, convertTo type: T.Type) -> Single<[T]> {
        return .create(subscribe: { (single) -> Disposable in
            self.getModels(endPoint: endPoint, convertTo: type, completion: { (result) in
                switch result {
                case .success(let models):
                    single(.success(models))
                case .failure(let error):
                    single(.error(error))
                }
            })
            return Disposables.create()
        })
    }

}
