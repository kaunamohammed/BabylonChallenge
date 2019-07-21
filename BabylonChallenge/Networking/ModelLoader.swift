//
//  ModelLoader.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 15/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

class ModelLoader: DomainModelGettable {
    
    private let networkRouter: NetworkRouter
    init(networkRouter: NetworkRouter) {
        self.networkRouter = networkRouter
    }
    
    func getModels<T>(endPoint: EndPoint, convertTo type: T.Type, completion: @escaping (Result<[T], NetworkError>) -> ()) where T : Decodable {
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
    func getModel<T>(endPoint: EndPoint, convertTo: T.Type, completion: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable {
        networkRouter.request(endPoint: endPoint) { (result) in
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
