//
//  ModelLoader.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 15/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift

typealias PostsLoader = ModelLoader<Post>
typealias UsersLoader = ModelLoader<User>
typealias CommentsLoader = ModelLoader<Comment>


class ModelLoader<T: Decodable> {
    
    private let networkRouter: NetworkRouter
    init(networkRouter: NetworkRouter) {
        self.networkRouter = networkRouter
    }
    
    func getModels(from endPoint: EndPoint, completion: @escaping (Result<[T], NetworkError>) -> ()) {
        networkRouter.request(endPoint: endPoint) { (result) in
            switch result {
            case .success(let data):
                do {
                    let models: [T] = try data.decoded()
                    completion(.success(models))
                } catch _ {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getModel(withID id: Int, endpoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> ()) {
        networkRouter.request(endPoint: endpoint) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model: T = try data.decoded()
                    completion(.success(model))
                } catch _ {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

// MARK: - Rx
extension ModelLoader {
    
    func getModels(from endPoint: EndPoint) -> Single<[T]> {
        return .create(subscribe: { (single) -> Disposable in
            self.getModels(from: endPoint, completion: { (result) in
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
    
    func getModel(withID id: Int, endpoint: EndPoint) -> Single<T> {
        return .create(subscribe: { (single) -> Disposable in
            self.getModel(withID: id, endpoint: endpoint, completion: { (result) in
                switch result {
                case .success(let model):
                    single(.success(model))
                case .failure(let error):
                    single(.error(error))
                }
            })
            return Disposables.create()
        })
    }
    
}
