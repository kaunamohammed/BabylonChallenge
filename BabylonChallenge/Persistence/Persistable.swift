//
//  Persistable.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 02/08/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift

enum PersistenceError: LocalizedError {
    case noResults
    case unrecognizedPersistedObject
    case failedToFetchResults

    var errorDescription: String? {
        switch self {
        case .noResults: return "There's nothing to display at the moment"
        case .unrecognizedPersistedObject: return "We couldn't find any matching results"
        case .failedToFetchResults: return "An issue occured getting results"
        }
    }

}

protocol Persistable {

    func insert<T: Storable>(_ objects: [T])
    func fetch<T: Storable>(_ object: T.Type, completion: @escaping ((Result<[T], PersistenceError>) -> Void))

}

extension Persistable {

    func fetch<T: Storable>(_ object: T.Type) -> Single<[T]> {
        return .create { (single) -> Disposable in
            self.fetch(object) { (result) in
                switch result {
                case .success(let objects):
                    single(.success(objects))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create()
        }
    }

}
